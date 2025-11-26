"""

Management command to ensure an admin user exists.

This runs automatically on Railway deployment to create the default admin.

"""

from django.core.management.base import BaseCommand

from django.contrib.auth.models import User

 

 

class Command(BaseCommand):

    help = 'Ensures a default admin user exists (creates if not found)'

 

    def handle(self, *args, **options):

        # Check if any superuser exists

        if User.objects.filter(is_superuser=True).exists():

            self.stdout.write(

                self.style.SUCCESS('✓ Admin user already exists')

            )

            return

 

        # Create default admin user

        try:

            User.objects.create_superuser(

                username='admin',

                email='admin@banelo.com',

                password='banelo2024',  # Default password

                first_name='Admin',

                last_name='User',

            )

            self.stdout.write(

                self.style.SUCCESS(

                    '✓ Created default admin user'

                )

            )

            self.stdout.write(

                self.style.WARNING(

                    '  Username: admin'

                )

            )

            self.stdout.write(

                self.style.WARNING(

                    '  Password: banelo2024'

                )

            )

            self.stdout.write(

                self.style.WARNING(

                    '  ⚠️  CHANGE THIS PASSWORD AFTER FIRST LOGIN!'

                )

            )

        except Exception as e:

            self.stdout.write(

                self.style.ERROR(f'✗ Failed to create admin user: {e}')

            )
from django.db import models
from django.utils import timezone
import uuid


# =====================================================
# MODELS SHARED WITH MOBILE APP (PostgreSQL)
# These tables are created and managed by the mobile app
# managed = False means Django won't try to create/modify these tables
# =====================================================

class Product(models.Model):
    """
    Product model - matches PostgreSQL products table
    All IDs are UUID in PostgreSQL
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    name = models.CharField(max_length=255)
    category = models.CharField(max_length=255)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.IntegerField(null=True, blank=True)
    inventory_a = models.IntegerField(null=True, blank=True)
    inventory_b = models.IntegerField(null=True, blank=True)
    cost_per_unit = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    image_uri = models.TextField(null=True, blank=True)
    description = models.TextField(null=True, blank=True)
    sku = models.CharField(max_length=255, null=True, blank=True)
    is_active = models.BooleanField(default=True, null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)
    updated_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'products'
        managed = False


class Sale(models.Model):
    """
    Sale model - matches PostgreSQL sales table
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    order_id = models.IntegerField(null=True, blank=True)
    product_name = models.CharField(max_length=255)
    category = models.CharField(max_length=255, null=True, blank=True)
    quantity = models.IntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    order_date = models.DateTimeField()
    product_firebase_id = models.UUIDField(null=True, blank=True)
    payment_mode = models.CharField(max_length=255, null=True, blank=True)
    gcash_reference_id = models.CharField(max_length=255, null=True, blank=True)
    cashier_username = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.product_name} - {self.quantity} - {self.order_date}"

    class Meta:
        db_table = 'sales'
        managed = False
        ordering = ['-order_date']


class Recipe(models.Model):
    """
    Recipe model - matches PostgreSQL recipes table
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    recipe_id = models.IntegerField(null=True, blank=True)
    product_firebase_id = models.UUIDField(null=True, blank=True)
    product_name = models.CharField(max_length=255, null=True, blank=True)
    instructions = models.TextField(null=True, blank=True)
    prep_time_minutes = models.IntegerField(null=True, blank=True)
    cook_time_minutes = models.IntegerField(null=True, blank=True)
    servings = models.IntegerField(null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)
    updated_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Recipe for {self.product_name}"

    class Meta:
        db_table = 'recipes'
        managed = False


class RecipeIngredient(models.Model):
    """
    RecipeIngredient model - matches PostgreSQL recipe_ingredients table
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    recipe_firebase_id = models.UUIDField(null=True, blank=True)
    recipe_id = models.IntegerField(null=True, blank=True)
    ingredient_firebase_id = models.UUIDField(null=True, blank=True)
    ingredient_name = models.CharField(max_length=255)
    quantity_needed = models.DecimalField(max_digits=10, decimal_places=2)
    unit = models.CharField(max_length=255, null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.ingredient_name} - {self.quantity_needed}"

    class Meta:
        db_table = 'recipe_ingredients'
        managed = False


class WasteLog(models.Model):
    """
    WasteLog model - matches PostgreSQL waste_logs table
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    product_firebase_id = models.UUIDField(null=True, blank=True)
    product_name = models.CharField(max_length=255)
    category = models.CharField(max_length=255, null=True, blank=True)
    quantity = models.IntegerField()
    reason = models.CharField(max_length=255, null=True, blank=True)
    waste_date = models.DateTimeField()
    recorded_by = models.CharField(max_length=255, null=True, blank=True)
    cost_impact = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.product_name} - {self.quantity} wasted"

    class Meta:
        db_table = 'waste_logs'
        managed = False
        ordering = ['-waste_date']


class User(models.Model):
    """
    User model - matches PostgreSQL users table
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    fname = models.CharField(max_length=255)
    lname = models.CharField(max_length=255)
    mname = models.CharField(max_length=255, null=True, blank=True)
    username = models.CharField(max_length=255)
    auth_email = models.CharField(max_length=255, null=True, blank=True)
    role = models.CharField(max_length=255, null=True, blank=True)
    status = models.CharField(max_length=255, null=True, blank=True)
    joined_date = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)
    updated_at = models.DateTimeField(null=True, blank=True)
    password_hash = models.CharField(max_length=255)

    def __str__(self):
        return f"{self.fname} {self.lname} ({self.username})"

    class Meta:
        db_table = 'users'
        managed = False


class AuditLog(models.Model):
    """
    AuditLog model - matches PostgreSQL audit_logs table (Mobile POS)
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    firebase_id = models.CharField(max_length=255, null=True, blank=True)
    username = models.CharField(max_length=255)
    action = models.CharField(max_length=255)
    description = models.TextField(null=True, blank=True)
    date_time = models.DateTimeField()
    status = models.CharField(max_length=255, null=True, blank=True)
    ip_address = models.CharField(max_length=255, null=True, blank=True)
    user_agent = models.TextField(null=True, blank=True)
    metadata = models.JSONField(null=True, blank=True)
    created_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.action} by {self.username} at {self.date_time}"

    class Meta:
        db_table = 'audit_logs'
        managed = False
        ordering = ['-date_time']


# =====================================================
# WEB DASHBOARD MODELS (Django-managed)
# =====================================================

class AuditTrail(models.Model):
    """
    Audit trail model - for tracking WEB dashboard user actions
    """
    id = models.AutoField(primary_key=True)
    action = models.CharField(max_length=255)
    details = models.TextField(null=True, blank=True)
    user_id = models.CharField(max_length=255, null=True, blank=True, db_column='user_id')
    user_name = models.CharField(max_length=255, null=True, blank=True, db_column='user_name')
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.action} by {self.user_name} at {self.timestamp}"

    class Meta:
        db_table = 'audit_trail'
        managed = True
        ordering = ['-timestamp']


class MLPrediction(models.Model):
    """
    ML Prediction model - stores forecasting predictions
    """
    id = models.AutoField(primary_key=True)
    product_firebase_id = models.CharField(max_length=255, unique=True, db_column='productFirebaseId')
    product_name = models.CharField(max_length=255, null=True, blank=True, db_column='productName')
    predicted_daily_usage = models.FloatField(db_column='predictedDailyUsage')
    avg_daily_usage = models.FloatField(db_column='avgDailyUsage')
    trend = models.FloatField()
    confidence_score = models.FloatField(db_column='confidenceScore')
    data_points = models.IntegerField(db_column='dataPoints')
    last_updated = models.DateTimeField(auto_now=True, db_column='lastUpdated')

    def __str__(self):
        return f"{self.product_name} - Prediction"

    class Meta:
        db_table = 'ml_predictions'
        managed = True


class MLModel(models.Model):
    """
    ML Model metadata - tracks training status
    """
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=200)
    is_trained = models.BooleanField(default=False, db_column='isTrained')
    last_trained = models.DateTimeField(null=True, blank=True, db_column='lastTrained')
    total_records = models.IntegerField(default=0, db_column='totalRecords')
    products_analyzed = models.IntegerField(default=0, db_column='productsAnalyzed')
    predictions_generated = models.IntegerField(default=0, db_column='predictionsGenerated')
    accuracy = models.IntegerField(default=0)
    model_type = models.CharField(max_length=200, default='Linear Regression (Moving Average)', db_column='modelType')
    training_period_days = models.IntegerField(default=90, db_column='trainingPeriodDays')

    def __str__(self):
        return self.name

    class Meta:
        db_table = 'ml_models'
        managed = True

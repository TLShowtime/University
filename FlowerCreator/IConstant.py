import abc

class IConstant(abc.ABC):
    BITS = 2**16
    CANTIDAD_INDIVIDUOS = 30
    CANTIDAD_BITS = 16
    GENERACION_MAX = 5
    INDIVIDUOS_TOMADOS  = 30
    RANGO = [50,25,5]
    LIMITE_RANGO_BITS = 5
    MUTATION_PROB = 0.075
    RANGO_RADIO_PINTAR = 4
    RANGO_DIMENSION_PINTAR = 15
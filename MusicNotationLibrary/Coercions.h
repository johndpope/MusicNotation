@import Foundation;
#ifdef TL_COERCIONS
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"
static NSNumber* num(NSInteger value)
{
    return [NSNumber numberWithInteger:value];
}
static NSNumber* numl(long value)
{
    return [NSNumber numberWithLong:value];
}
static NSNumber* numf(float value)
{
    return [NSNumber numberWithFloat:value];
}
static NSNumber* numd(double value)
{
    return [NSNumber numberWithDouble:value];
}
#pragma clang diagnostic pop
#endif
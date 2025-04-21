<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Lucky Sol Resort and Hotel</title>
                <style>
                    body { 
                        font-family: Arial, sans-serif; 
                        margin: 20px; 
                        background-color: #F0F8FF; 
                        font-size: 16px;
                    }
                    h1 { 
                        color: #2E8B57; 
                    }
                    h2 { 
                        color: #4682B4; 
                    }
                    table { 
                        width: 100%; 
                        border-collapse: collapse; 
                        margin: 20px 0; 
                    }
                    th, td { 
                        border: 1px solid #ddd; 
                        padding: 8px; 
                        text-align: left;
                    }
                    th { 
                        background-color: #40E0D0; 
                        color: white; 
                    }
                    tr:nth-child(even) { 
                        background-color: #E0FFFF; 
                    }
                    tr:hover { 
                        background-color: #FFDDC1; 
                        transition: background-color 0.3s ease;
                    }
                    ul { 
                        list-style-type: square; 
                    }
                    li { 
                        margin-bottom: 5px; 
                    }
                    .table-container { 
                        overflow-x: auto; 
                    }
                </style>
            </head>
            <body>
                <h1><xsl:value-of select="HotelDataRecord/Hotel/Name"/></h1>
                <h2>Location</h2>
                <p><xsl:value-of select="HotelDataRecord/Hotel/Location"/></p>
                <h2>Description</h2>
                <p><xsl:value-of select="HotelDataRecord/Hotel/HotelDescription"/></p>

                <h2>Contact Information</h2>
                <p>Phone: <xsl:value-of select="HotelDataRecord/Hotel/Contacts/contact/PhoneNumber"/></p>
                <p>Email: <xsl:value-of select="HotelDataRecord/Hotel/Contacts/contact/Email"/></p>

                <h2>Services</h2>
                <ul>
                    <xsl:for-each select="HotelDataRecord/Hotel/Services/Service">
                        <li>
                            <strong><xsl:value-of select="Name"/></strong>: <xsl:value-of select="Description"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h2>Amenities</h2>
                <ul>
                    <xsl:for-each select="HotelDataRecord/Hotel/Amenities/Amenity">
                        <li>
                            <strong><xsl:value-of select="Name"/></strong>: <xsl:value-of select="Description"/>
                        </li>
                    </xsl:for-each>
                </ul>

                <h2>Room Types</h2>
                <div class="table-container">
                    <table>
                        <tr>
                            <th>Type</th>
                            <th>Category</th>
                            <th>Rate (PHP)</th>
                        </tr>
                        <xsl:for-each select="HotelDataRecord/Rooms/Room">
                            <tr>
                                <td><xsl:value-of select="Type"/></td>
                                <td><xsl:value-of select="Category"/></td>
                                <td><xsl:value-of select="Rate"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>

                <h2>Payments</h2>
                <div class="table-container">
                    <table>
                        <tr>
                            <th>Customer ID</th>
                            <th>Amount (PHP)</th>
                            <th>Method</th>
                            <th>Date</th>
                        </tr>
                        <xsl:for-each select="HotelDataRecord/Payments/Payment">
                            <tr>
                                <td><xsl:value-of select="CustomerID"/></td>
                                <td><xsl:value-of select="Amount"/></td>
                                <td><xsl:value-of select="Method"/></td>
                                <td><xsl:value-of select="Date"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>

                <h2>Reservations (Sorted by Customer ID)</h2>
<div class="table-container">
    <table>
        <tr>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Address</th>
            <th>Check-In</th>
            <th>Check-Out</th>
            <th>Room Type</th>
        </tr>
        <xsl:for-each select="HotelDataRecord/Reservations/Reservation">
            <xsl:sort select="CustomerID" data-type="number" order="ascending"/>
            <tr>
                <td><xsl:value-of select="CustomerID"/></td>
                <td><xsl:value-of select="Name"/></td>
                <td><xsl:value-of select="Address"/></td>
                <td><xsl:value-of select="CheckIn"/></td>
                <td><xsl:value-of select="CheckOut"/></td>
                <td><xsl:value-of select="RoomType"/></td>
            </tr>
        </xsl:for-each>
    </table>
</div>

                <h2>Filtered Reservations (Luxury Rooms Only)</h2>
                <div class="table-container">
                    <table>
                        <tr>
                            <th>Customer ID</th>
                            <th>Customer Name</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                        </tr>
                        <xsl:for-each select="HotelDataRecord/Reservations/Reservation">
                            <xsl:if test="translate(RoomType, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz') = 'suite'">
                                <tr>
                                    <td><xsl:value-of select="CustomerID"/></td>
                                    <td><xsl:value-of select="Name"/></td>
                                    <td><xsl:value-of select="CheckIn"/></td>
                                    <td><xsl:value-of select="CheckOut"/></td>
                                </tr>
                            </xsl:if>
                        </xsl:for-each>
                    </table>
                </div>

                <h2>Payment Method Summary</h2>
                <div class="table-container">
                    <table>
                        <tr>
                            <th>Customer ID</th>
                            <th>Payment Method</th>
                            <th>Payment Type</th>
                        </tr>
                        <xsl:for-each select="HotelDataRecord/Payments/Payment">
                            <tr>
                                <td><xsl:value-of select="CustomerID"/></td>
                                <td><xsl:value-of select="Method"/></td>
                                <td>
                                    <xsl:choose>
                                        <xsl:when test="Method = 'Credit Card'">Online</xsl:when>
                                        <xsl:when test="Method = 'Bank Transfer'">Online</xsl:when>
                                        <xsl:otherwise>Offline</xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

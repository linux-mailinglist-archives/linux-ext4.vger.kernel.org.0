Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D329CC946D
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 00:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJBWoH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Oct 2019 18:44:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35578 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBWoG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Oct 2019 18:44:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92MdRuV124847;
        Wed, 2 Oct 2019 22:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=pohsQLvmpkvh6YAwWDQ5prjFxmRKEJWYiY3NOclJ8kU=;
 b=VL58cz80LLv03M8/0U25N26F6V/5VdAmMtOHRASeEUegkv38sCUJG5G6LIYYLekXGRs2
 JDxjpaPKlVen+9Lf8cSJkOATUYamGRezcvfFASYkeV/MJPDY+kvxfe9XaCXNR1/sYb+X
 GQ3H9HH0BzRnnuilKS7P4wNyFtR9yJf3CyFEhzqvhMh+tkshyO9OVTnAjnTUmgL04cZd
 JTnmjo8Npp3DxkHunS9u0sSlASP/tOhzh61fHepG/mbAVILhCmj9KJZ+4FWtR67pqKvS
 /83gH86ppfx+T6NMqApJYOpQcUt8HuL1wz/w080ov5fHgBFvwSxexF+3GFdUkveho+Fc XA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2va05ryx6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 22:44:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92MhmeC161944;
        Wed, 2 Oct 2019 22:44:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vc9dmfmrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 22:44:02 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x92Mi1Aq025081;
        Wed, 2 Oct 2019 22:44:01 GMT
Received: from localhost (/10.159.254.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 15:44:01 -0700
Date:   Wed, 2 Oct 2019 15:44:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: ext4 conference call for 3 Oct 2019?
Message-ID: <20191002224400.GA13093@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=698
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=760 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020182
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

What time is tomorrow's ext4 conference call? :)

--Darrick

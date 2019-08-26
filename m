Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D69D5D9
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfHZSbS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 14:31:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfHZSbR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Aug 2019 14:31:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QIE7SP006539;
        Mon, 26 Aug 2019 18:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=zL6/7NQ+dIS9XboDSm0uY3zB4jZKhKTvWqBRqqkcK+8=;
 b=KWNMExenIiu+B6H8fGlWOjwE0euifKbRQydbfXa58Da4ewrcY8OjgUTYFd5rxgD4xUXo
 xbMx6BOqmutyiK/GmL7dYbKIHcpQtVXMnVh+twkeydhOv7MhMSltN6jqEj6s4KvY2JGH
 1beMiuUX2SWUibU+4RzaNUrrj07yC0QrLf07zBlAJ9j+UvZiYNcBUbjG5om/yInu9jFp
 K+S+oFgahWq8mg3WmaWIJdSpAc03zNffgEyRBskUyTrwFVBch9sHOX4hEc5CdbIjy2EZ
 Dh8b6/wrSwuhwPIwliw+NWJTEES0OuadXvW4eqCn64rUAVYA6Anhfkj5Pe3vgfi72sn5 gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2umjjqrxsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 18:31:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7QIE7Pg040863;
        Mon, 26 Aug 2019 18:31:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2umj2xq0ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 18:31:10 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7QIV8Vn015267;
        Mon, 26 Aug 2019 18:31:08 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 11:31:08 -0700
Date:   Mon, 26 Aug 2019 11:31:07 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org
Subject: Re: question about jbd2 checksum v2 and v3 flag
Message-ID: <20190826183107.GA1037476@magnolia>
References: <CAPLK-i8xE4n8BJ-Beu0f80PC2W6b-A30nwcz+V_bCb_iAyB++Q@mail.gmail.com>
 <FF31C738-6B87-434B-9736-76286ED0F8E3@dilger.ca>
 <20190826165106.GF4918@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826165106.GF4918@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260177
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260177
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 26, 2019 at 12:51:06PM -0400, Theodore Y. Ts'o wrote:
> On Sun, Aug 25, 2019 at 09:05:36PM -0600, Andreas Dilger wrote:
> > See description of the compat/incompat/ro_compat fields at:
> > 
> > https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#The_Super_Block
> >
> 
> Hey Andreas,
> 
> As an aside, thanks for puting the above wiki page.  Any chance you
> could also send a patch to update Documentation/filesystems/ext4/super.rst?

Huh?  That wiki page was ported to the ^^^^^ rst file.

--D

> Many thanks!!
> 
> 					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074A82CE520
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgLDB2u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 3 Dec 2020 20:28:50 -0500
Received: from smtp.h3c.com ([60.191.123.50]:2010 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgLDB2u (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Dec 2020 20:28:50 -0500
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
        by h3cspam02-ex.h3c.com with ESMTP id 0B41RCuI075840;
        Fri, 4 Dec 2020 09:27:12 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 09:27:13 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.2106.002; Fri, 4 Dec 2020 09:27:13 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ext4: remove the null check of bio_vec page
Thread-Topic: [PATCH] ext4: remove the null check of bio_vec page
Thread-Index: AQHWpruDhYzwIts0bkGkoCqDPV0JCqmhVUyAgEPTgYCAAULUUA==
Date:   Fri, 4 Dec 2020 01:27:13 +0000
Message-ID: <1758a0c58d174070915534f538aaf52d@h3c.com>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
 <20201021102503.GC19726@quack2.suse.cz> <20201203141127.GF441757@mit.edu>
In-Reply-To: <20201203141127.GF441757@mit.edu>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 0B41RCuI075840
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Ted :)

-----Original Message-----
From: Theodore Y. Ts'o [mailto:tytso@mit.edu] 
Sent: Thursday, December 03, 2020 10:11 PM
To: Jan Kara <jack@suse.cz>
Cc: tianxianting (RD) <tian.xianting@h3c.com>; adilger.kernel@dilger.ca; linux-ext4@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page

On Wed, Oct 21, 2020 at 12:25:03PM +0200, Jan Kara wrote:
> On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> > bv_page can't be NULL in a valid bio_vec, so we can remove the NULL 
> > check, as we did in other places when calling 
> > bio_for_each_segment_all() to go through all bio_vec of a bio.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> 
> Thanks for the patch. It looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted

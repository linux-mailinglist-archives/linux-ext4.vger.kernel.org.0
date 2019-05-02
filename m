Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B592A1239F
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2019 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEBUvG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 May 2019 16:51:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58694 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBUvG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 May 2019 16:51:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42KmuqX024139;
        Thu, 2 May 2019 20:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VvKINyBzW2q4bBIDucNySktnEe9OuwM30l3irscZ2PE=;
 b=vC6fVf8xH4MJXicAFKPG86VS/BKL6wGWJTHJsfOhGSDV6cSCG7Gr+E98Se/HdcYR6wcw
 n1xJ7iQck27XydpCFeMA8VdlplnwiGBMOdT719F4FyR07G36sVVCbEy5D9wVzyhLQsfm
 rxeFNsSTzRA7Glew6tv3rojHLh0LgAWjjMKjKFzAQHFpuVHQqoFDi4V8svipFD2+nnTt
 pLWrjKd6yLFIeXh/ZU/UC3TudKqcj/YJ+jOh7SGY5VEDyDFgyFRQDjAih1gyMVOluW1j
 PRB19pX3vz+82gBrqaNSlvszDhId+iA7AlB/iwnwRD5lBX3hOW5RD6hwOUoyL1v91SNR jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2s6xhykade-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 20:50:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x42KnQtw178921;
        Thu, 2 May 2019 20:50:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2s6xhh9mec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 May 2019 20:50:58 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x42KovCa002797;
        Thu, 2 May 2019 20:50:57 GMT
Received: from localhost (/10.145.179.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 May 2019 13:50:57 -0700
Date:   Thu, 2 May 2019 13:50:56 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-ext4@vger.kernel.org
Subject: Re: Change feature name from fname_encoding to casefold?
Message-ID: <20190502205056.GA5193@magnolia>
References: <20190413054317.7388-1-krisman@collabora.com>
 <20190413054317.7388-9-krisman@collabora.com>
 <20190502162527.GC25007@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502162527.GC25007@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905020130
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9245 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905020131
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 02, 2019 at 12:25:27PM -0400, Theodore Ts'o wrote:
> Given how we've simplified how we handle Unicode --- in particular,
> not doing any kind of normalization unless we are doing case-folding
> compares, I think it will be more user-friendly if we rename the
> feature from fname_encoding to casefold.

TBH /me hadn't done enough reviewing even to notice the feature was
named 'fname_encoding' (whatever that means -- encoded how?).
IMHO 'casefold' is more descriptive about what the feature provides
(folding case for directory name comparisons, right?)

--D

> 
> What do you think?  Any objections?
> 
> 					- Ted

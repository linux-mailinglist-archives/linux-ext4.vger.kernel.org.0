Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3771F2FF73
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 17:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE3P3j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 11:29:39 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34910 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfE3P3j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 May 2019 11:29:39 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UFJNKj038593;
        Thu, 30 May 2019 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=scZa7iY7XtlpJUf9HDfflls8FvP/S/nfBbasPNl8IkY=;
 b=hzsJO1a5D2aKz16zAHvRp5AGh/H85RnwJpCMiC5Vs350afTrsBrZuUYxh/KiYA9hswov
 uy5SSok6yW02GSDY0ntwtQ9/zT9sqlkqH9Gc7FKMdh1OAB6K94RTkZhtx70vfLySn6vF
 eKDFMSeCrTalQhiPdStEQV6FmKzaWGf7UezqpPyEpCCG6s1J4FygeOG5hK6asIMeeqm3
 axk2iCQSITjV3anFbLQBXWboMYixUD58Er/olpbe1YQTWeedJMel+16leXd3exPuin/d
 khcrgPqNmT8XTX3Ppmu8LkDecx1W6KFkZit0roA9OYYqANTQCpsL2/eEhlcTl9FhZbrQ 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7ds4kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:29:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UFRtNL057896;
        Thu, 30 May 2019 15:29:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2srbdy2j6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 15:29:05 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UFSukp025283;
        Thu, 30 May 2019 15:28:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 08:28:56 -0700
Date:   Thu, 30 May 2019 08:28:55 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, "Theodore Ts'o" <tytso@mit.edu>,
        xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: How to package e2scrub
Message-ID: <20190530152855.GA5390@magnolia>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529182111.GA5220@magnolia>
 <20190530060426.GA30438@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530060426.GA30438@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=917
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=960 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300109
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 11:04:26PM -0700, Christoph Hellwig wrote:
> On Wed, May 29, 2019 at 11:21:11AM -0700, Darrick J. Wong wrote:
> > Indeed.  Eric picked "xfsprogs-xfs_scrub" for Rawhide, though I find
> > that name to be very clunky and would have preferred "xfs_scrub".
> 
> Why not just xfs-scrub?

Slight preference for the package sharing a name with its key
ingredient:

# xfs_scrub /home
Bad command or file name
# apt install xfs_scrub
<stuff>
# xfs_scrub /home
WARNING: ALL DATA ON NON-REMOVABLE DISK
DRIVE C: WILL BE LOST!
Proceed with Format (Y/N)?

--D

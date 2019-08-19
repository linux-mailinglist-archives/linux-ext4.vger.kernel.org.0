Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3089499E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2019 18:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfHSQRQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Aug 2019 12:17:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfHSQRN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Aug 2019 12:17:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JGETdk049388;
        Mon, 19 Aug 2019 16:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=7zyrIiKS35+Y9IanEKmiHBF4KlAhMcS3b9oDWp5zctw=;
 b=NUtRqi1bvW+AtAeCOWy/ptlGODHYzehPA1j2LrmXYZ/rafE6nyLOrexrjY8Hv4SpuZv7
 ZZio5+1I7TRrU3+Poed5aOEiFg/DZ8bnjJoTCToonzUOUsKzHY/pnwzXkIDS//lgdRVk
 kWYDtdkA9JZR3CQJ7YRPuoppmD8w4BFszowC7pAEyoy3tskVynXrKFXb9gbrxVutxQKa
 CrKqc/vjiLwCMCCw57XgiX3nqOTIjUepywKgtLDGLoSesAd6NnufqRXZRNft5fiOSmne
 14qkOncZ/kP62S5Mho3hc0fV7u6dVmVkF34wx3ZOEQIZ72vGxltyWIj7iYxIX2Vjug99 hA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ue90t8n4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:17:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7JGEME1125282;
        Mon, 19 Aug 2019 16:17:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ue6qer9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:17:08 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7JGH6fY018481;
        Mon, 19 Aug 2019 16:17:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Aug 2019 09:17:06 -0700
Date:   Mon, 19 Aug 2019 09:17:05 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: JBD2 transaction running out of space
Message-ID: <20190819161705.GB15175@magnolia>
References: <20190819085759.GB2491@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819085759.GB2491@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908190173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908190173
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 19, 2019 at 10:57:59AM +0200, Jan Kara wrote:
> Hello,
> 
> I've recently got a bug report where JBD2 assertion failed due to
> transaction commit running out of journal space. After closer inspection of
> the crash dump it seems that the problem is that there were too many
> journal descriptor blocks (more that max_transaction_size >> 5 + 32 we
> estimate in jbd2_log_space_left()) due to descriptor blocks with revoke
> records. In fact the estimate on the number of descriptor blocks looks
> pretty arbitrary and there can be much more descriptor blocks needed for
> revoke records. We need one revoke record for every metadata block freed.
> So in the worst case (1k blocksize, 64-bit journal feature enabled,
> checksumming enabled) we fit 125 revoke record in one descriptor block.  In
> common cases its about 500 revoke records per descriptor block. Now when
> we free large directories or large file with data journalling enabled, we can
> have *lots* of blocks to revoke - with extent mapped files easily millions
> in a single transaction which can mean 10k descriptor blocks - clearly more
> than the estimate of 128 descriptor blocks per transaction ;)

Can jbd2 make the jbd2_journal_revoke caller wait until it has
checkpointed the @blocknr block if it has run out of revoke record
space?

> Now users clearly don't hit this problem frequently so this is not common
> case but still it is possible and malicious user could use this to DoS the
> machine so I think we need to get even the weird corner-cases fixed. The
> question is how because as sketched above the worst case is too bad to
> account for in the common case. I have considered three options:
> 
> 1) Count number of revoke records currently in the transaction and add
> needed revoke descriptor blocks to the expected transaction size. This is
> easy enough but does not solve all the corner cases - single handle
> can add lot of revoke blocks which may overflow the space we reserve for
> descriptor blocks.
> 
> 2) Add argument to jbd2_journal_start() telling how many metadata blocks we
> are going to free and we would account necessary revoke descriptor blocks
> into reserved credits. This could work, we would generally need to pass
> inode->i_blocks / blocksize as the estimate of metadata blocks to free (for
> inodes to which this applies) as we don't have better estimate but I guess
> that's bearable. It would require some changes on ext4 side but not too
> intrusive.

What happens if iblocks / blocksize revoke records exceeds the size of
the journal?

--D

> 3) Use the fact that we need to revoke only blocks that are currently in
> the journal. Thus the number of revoke records we really may need to store
> is well bound (by the journal size). What is a bit painful is tracking of
> which blocks are journalled. We could use a variant of counting Bloom
> filters to store that information with low memory consumption (say 64k of
> memory in common case) and high-enough accuracy but still that will be some
> work to write. On the plus side it would reduce the amount revoke records
> we have to store even in common case.
> 
> Overall I'm probably leaning towards 2) but I'm happy to hear more opinions
> or ideas :)
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

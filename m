Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE197BD14B
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Oct 2023 01:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjJHXpY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Oct 2023 19:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344986AbjJHXpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Oct 2023 19:45:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80708AB
        for <linux-ext4@vger.kernel.org>; Sun,  8 Oct 2023 16:45:21 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ae2ec1a222so2844181b6e.2
        for <linux-ext4@vger.kernel.org>; Sun, 08 Oct 2023 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696808721; x=1697413521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iIUGA5nyGTXIkeVMBhQE5fUan1nQD7xdjAl3FqxZfHs=;
        b=f5MtScfDYvUPb3PwTlai8laM9QFdEr8ZDPhoTRQ0KRc8XqEdovj0S90jUsGmaOAhO0
         0TSgVnUxaKTSMOsOyUVLEtm1aqgsj5Toyi7VgdfgbtM/pT1OYIfC2qu5LPdfWiQ+Y7R/
         OnUytDPAcCOs/VVxa3OcQMchQuzrvwvF3GWrN32qmGwQ1SgDSx4eNBv5qYFjZzG8eWji
         BA2zvwAx9q5qf0JR/FeYA0bTQghKMp5UydpzCqLnSuIbbxv3ZStpfyy2rL/gTHTDLd+V
         jXT4Cuz329FdeFaqKq0PCs3rCTziuIZv0YRDvMg0QqroGRVNl+YTYhfzOpSyG0j/2Vh8
         q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696808721; x=1697413521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIUGA5nyGTXIkeVMBhQE5fUan1nQD7xdjAl3FqxZfHs=;
        b=wUf8U6v2NT9EpIrg34ZZhovozFLjsRTpqtf/qum3rr78J/jDfa4/VAuJuhkdc4Q2Sd
         ynCr+6iuNcLeO/zljgMzhtLnwY/0mgVJuAEexoADpwootDBdxkvbbKb078/3wMCOh02Q
         joW0dpgr4P0Y0uts6hL9RSNdNwrZg5+4AtqqL7JEE2M5xgkOyZSKLnhSzyO8OcsG8JIn
         S8RsM5l6CoA9iCPVL7nIgzAcmqhdlwjrY0yGkHOC+4g3xwsvdANGi1dMhvuuqlCJXEC3
         Nm9jlyNWNePdYbKRTRCUS97Dbp44rUf2llIsglD4juVm7c+OHcdzq1IM9TUIOKNINX/P
         M2Bw==
X-Gm-Message-State: AOJu0Yyx4pNIVLRRRzUftfp/ZpgACA5lX/94TYZD2r+4ROYjXe5L0Po6
        afIEIuqa+PJixdFjWT0TM3l3MA==
X-Google-Smtp-Source: AGHT+IE4ZtKoa5V64XLddUAQlfgY0O4kC79VmJ41/fARv+skVul5l6HD62OAku+HYlksQ55wgVACwg==
X-Received: by 2002:a05:6808:1406:b0:3ae:108c:57b3 with SMTP id w6-20020a056808140600b003ae108c57b3mr20743909oiv.39.1696808720820;
        Sun, 08 Oct 2023 16:45:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79153000000b0069353ac3d38sm5090447pfi.69.2023.10.08.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 16:45:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpdSY-00BIBn-0I;
        Mon, 09 Oct 2023 10:45:18 +1100
Date:   Mon, 9 Oct 2023 10:45:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [RFC PATCH 7/5] xfs: add block device provisioning for fallocate
Message-ID: <ZSM/Dvr1LWICYd2C@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Provision space in the block device for preallocated file space when
userspace asks for it. Make sure to do this outside of transaction
context so it can fail without causing a filesystem shutdown.

XXX: async provisioning submission/completion interface would be
really useful here....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_bmap_util.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fcefab687285..5dddd1e7bc47 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -772,6 +772,37 @@ xfs_free_eofblocks(
 	return error;
 }
 
+static int
+xfs_bmap_provision_blocks(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	int			nimaps)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_buftarg	*target;
+	int			i;
+
+	if (!xfs_is_provisioning_blocks(mp))
+		return 0;
+
+	target = xfs_inode_buftarg(ip);
+	if (!target->bt_needs_provisioning)
+		return 0;
+
+	for (i = 0; i < nimaps; i++) {
+		int	error;
+
+		error = blkdev_issue_provision(target->bt_bdev,
+				XFS_FSB_TO_DADDR(mp, imap->br_startblock),
+				XFS_FSB_TO_BB(mp, imap->br_blockcount),
+				GFP_KERNEL, 0);
+		ASSERT(error != -EOPNOTSUPP);
+		if (error)
+			return error;
+	}
+	return 0;
+}
+
 int
 xfs_alloc_file_space(
 	struct xfs_inode	*ip,
@@ -780,7 +811,6 @@ xfs_alloc_file_space(
 {
 	xfs_mount_t		*mp = ip->i_mount;
 	xfs_off_t		count;
-	xfs_filblks_t		allocated_fsb;
 	xfs_filblks_t		allocatesize_fsb;
 	xfs_extlen_t		extsz, temp;
 	xfs_fileoff_t		startoffset_fsb;
@@ -884,15 +914,17 @@ xfs_alloc_file_space(
 		if (error)
 			break;
 
-		allocated_fsb = imapp->br_blockcount;
-
 		if (nimaps == 0) {
 			error = -ENOSPC;
 			break;
 		}
 
-		startoffset_fsb += allocated_fsb;
-		allocatesize_fsb -= allocated_fsb;
+		error = xfs_bmap_provision_blocks(ip, imapp, nimaps);
+		if (error)
+			break;
+
+		startoffset_fsb += imapp->br_blockcount;
+		allocatesize_fsb -= imapp->br_blockcount;
 	}
 
 	return error;

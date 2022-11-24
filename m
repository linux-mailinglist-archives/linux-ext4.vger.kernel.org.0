Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C0763704A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Nov 2022 03:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiKXCNo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 21:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKXCNn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 21:13:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC1CB9D6
        for <linux-ext4@vger.kernel.org>; Wed, 23 Nov 2022 18:13:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 544F4B825CD
        for <linux-ext4@vger.kernel.org>; Thu, 24 Nov 2022 02:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07869C433C1;
        Thu, 24 Nov 2022 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669256020;
        bh=5cxyBUETcnNM7OFYIjnqakRaNJpPL7aJIumTpw3ATXw=;
        h=Date:From:To:Cc:Subject:From;
        b=eac7ZJxOhFSZrLTCZgVBp7P0n396vKCLhAIKFPpVQX+l2oS7RGWFzLAoG+ydUXADs
         qn/3ZqJ0VY0zulkDw3QsQVpTVsJgktESBqQgpUNLz3LRPKNcYFqHEpoM4WTgHdMXn0
         P4A/FtGv6EoubakhnNWyBQAVBoNaaYVEjyQHoUTrOJ1rSSjkxDS+fcUCoQH37vrs3F
         QgM9WRvZJfGsBklwgVymlXM607p/J3Thii0nTI3ZXmRWDDTz9XnMc4uI4x4Lr0o4Mw
         GDr53RsJzq8MZG5PFDqC8vD2TmhRW64JA5KZ9OF/lz114Vc8MCR6uY/FUSOBThpwSN
         ZmNMvJNrBDwVg==
Date:   Wed, 23 Nov 2022 18:13:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     paul kairis <kairis@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] e2scrub_all: fix typo in manpage
Message-ID: <Y37TU3KjcTk1B4TU@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Fix this reported typo.

Reported-by: paul kairis <kairis@gmail.com>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/e2scrub_all.8.in |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scrub/e2scrub_all.8.in b/scrub/e2scrub_all.8.in
index c33c18f6..99bdc0d4 100644
--- a/scrub/e2scrub_all.8.in
+++ b/scrub/e2scrub_all.8.in
@@ -1,7 +1,7 @@
 .TH E2SCRUB 8 "@E2FSPROGS_MONTH@ @E2FSPROGS_YEAR@" "E2fsprogs version @E2FSPROGS_VERSION@"
 .SH NAME
 e2scrub_all - check all mounted ext[234] file systems for errors.
-.SH SYNOPSYS
+.SH SYNOPSIS
 .B
 e2scrub_all [OPTION]
 .SH DESCRIPTION

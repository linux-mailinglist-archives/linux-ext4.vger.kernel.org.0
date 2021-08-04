Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938E3E08BB
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 21:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbhHDTZi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 15:25:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44449 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240715AbhHDTZf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 15:25:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 174JPD2X024562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Aug 2021 15:25:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2297115C3DD2; Wed,  4 Aug 2021 15:25:13 -0400 (EDT)
Date:   Wed, 4 Aug 2021 15:25:13 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Carlos Carvalho <carlos@fisica.ufpr.br>,
        linux-ext4@vger.kernel.org, Theodore Tso <tytso@google.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: bug with large_dir in 5.12.17
Message-ID: <YQrpmUq/y3T/L2E6@mit.edu>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
 <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FE9762B-6C6B-4A44-AC99-22192B76C060@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 29, 2021 at 10:23:35PM +0300, Благодаренко Артём wrote:
> Hello,
> 
> It looks like the fix b5776e7524afbd4569978ff790864755c438bba7 "ext4: fix potential htree index checksum corruption” introduced this regression.
> I reverted it and my test from previous message passed the dangerous level of 1570000 names count.
> Now test is still in progress. 2520000 names are already created.
> 
> I am searching the way to fix this.
> 
> Best regards,
> Artem Blagodarenko.

Hi Artem, did you have a chance to take a look at some of the possible
fixes which I floated on this thread?

Do you have any objections if I take this and send it to Linus?

Thanks,

					- Ted

From fa8db30806b4e83981c65f18f98de33f804012d9 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 4 Aug 2021 14:23:55 -0400
Subject: [PATCH] ext4: fix potential htree correuption when growing large_dir
 directories
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit b5776e7524af ("ext4: fix potential htree index checksum
corruption) removed a required restart when multiple levels of index
nodes need to be split.  Fix this to avoid directory htree corruptions
when using the large_dir feature.

Cc: stable@kernel.org # v5.11
Cc: Благодаренко Артём <artem.blagodarenko@gmail.com>
Fixes: b5776e7524af ("ext4: fix potential htree index checksum corruption)
Reported-by: Denis <denis@voxelsoft.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 5fd56f616cf0..f3bbcd4efb56 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2517,7 +2517,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				goto journal_error;
 			err = ext4_handle_dirty_dx_node(handle, dir,
 							frame->bh);
-			if (err)
+			if (restart || err)
 				goto journal_error;
 		} else {
 			struct dx_root *dxroot;
-- 
2.31.0


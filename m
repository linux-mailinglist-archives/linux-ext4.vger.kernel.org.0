Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCD1196A08
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 00:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgC1XPs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 19:15:48 -0400
Received: from mx.sdf.org ([205.166.94.20]:56477 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgC1XPr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 28 Mar 2020 19:15:47 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SNFaJP013294
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 23:15:37 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SNFawb005993;
        Sat, 28 Mar 2020 23:15:36 GMT
Date:   Sat, 28 Mar 2020 23:15:36 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 08/50] fs/ext4/ialloc.c: Replace % with
 reciprocal_scale() TO BE VERIFIED
Message-ID: <20200328231536.GA11951@SDF.ORG>
References: <202003281643.02SGh9vH007105@sdf.org>
 <9A60C390-349E-4A90-A812-F04EB5A82136@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A60C390-349E-4A90-A812-F04EB5A82136@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 28, 2020 at 04:56:17PM -0600, Andreas Dilger wrote:
> On Mar 18, 2019, at 7:32 PM, George Spelvin <lkml@sdf.org> wrote:
>> Does the name hash algorithm have to be stable? In that case, this
>> change would alter it.  But it appears to use s_hash_seed which
>> is regenerated on "e2fsck -D", so maybe changing it isn't a big deal.
> 
> This function is only selecting a starting group when searching for
> a place to allocate a directory.  It does not need to be stable.
> 
> The use of the name hash was introduced in the following commit:
> 
>     f157a4aa98a18bd3817a72bea90d48494e2586e7
>     Author:     Theodore Ts'o <tytso@mit.edu>
>     AuthorDate: Sat Jun 13 11:09:42 2009 -0400
> 
>     ext4: Use hash of topdir directory name for Orlov parent group
> 
>     Instead of using a random number to determine the goal parent group
>     for Orlov top directories, use a hash of the directory name.  This
>     allows for repeatable results when trying to benchmark filesystem
>     layout algorithms.
> 
>     Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
> 
> So I think the current patch is fine.  The for-loop construct of
> using "++g == ngroups && (g = 0)" to wrap "g" around is new to me,
> but looks correct.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thank you.  Standing back and looking from higher altitude, I missed
a second modulo at fallback_retry: which should be made consistent,
so I need a one re-spin.

Also, we could, if desired, eliminate the i variable entirely
using the fact that we have a copy of the starting position cached
in parent_group.  I.e.

 		g = parent_group = reciprocal_scale(grp, ngroups);
-		for (i = 0; i < ngroups; i++, ++g == ngroups && (g = 0)) {
+		do {
 			...
-		}
+			if (++g == ngroups)
+				g = 0;
+		} while (g != parent_group);

Or perhaps the following would be simpler, replacing the modulo
with a conditional subtract:

-		g = parent_group = reciprocal_scale(grp, ngroups);
+		parent_group = reciprocal_scale(grp, ngroups);
-		for (i = 0; i < ngroups; i++, ++g == ngroups && (g = 0)) {
+		for (i = 0; i < ngroups; i++) {
+			g = parent_group + i;
+			if (g >= ngroups)
+				g -= ngroups;

The conditional branch starts out always false, and ends up always true,
but except for a few bobbles when it switches, branch prediction should
handle it very well.

Any preference?

(Seriously, thank you for a second set of eyes.  This patch set
contains so many almost-identical changes that my eyes were glazing
over and I couldn't see bugs.)

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E087196A1D
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 00:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC1X4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 19:56:02 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35987 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1X4B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 19:56:01 -0400
X-Originating-IP: 50.39.173.182
Received: from localhost (50-39-173-182.bvtn.or.frontiernet.net [50.39.173.182])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5A6551BF205;
        Sat, 28 Mar 2020 23:55:56 +0000 (UTC)
Date:   Sat, 28 Mar 2020 16:55:47 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix incorrect group count in ext4_fill_super error
 message
Message-ID: <20200328235547.GB27571@localhost>
References: <8b957cd1513fcc4550fe675c10bcce2175c33a49.1585431964.git.josh@joshtriplett.org>
 <04E7F659-18B0-4CD2-8DE9-F69310BC3B06@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04E7F659-18B0-4CD2-8DE9-F69310BC3B06@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 28, 2020 at 05:07:55PM -0600, Andreas Dilger wrote:
> On Mar 28, 2020, at 3:54 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> > 
> > ext4_fill_super doublechecks the number of groups before mounting; if
> > that check fails, the resulting error message prints the group count
> > from the ext4_sb_info sbi, which hasn't been set yet. Print the freshly
> > computed group count instead (which at that point has just been computed
> > in "blocks_count").
> > 
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> > Fixes: 4ec1102813798 ("ext4: Add sanity checks for the superblock before mounting the filesystem")
> 
> Modulo the compiler warning pointed out by kbuild test robot, I think the
> patch is correct, but was definitely confusing to read within the shown
> context, since "blocks_count" definitely doesn't seem to be "groups count"
> (it *is* the "groups count", but is just used as a temporary variable).

I agree that the code and patch read confusingly due to the (lack of)
context. The commit message attempted to explain that, but clearer code
seems preferable to confusing-but-explained code.

I sent a new version of this patch, which instead just moves the
assignment to sbi's group count earlier, so that the error message can
continue referencing it that way. (That also addresses the warning.)

- Josh Triplett

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010411A08EF
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 10:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgDGIJc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 04:09:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35125 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGIJc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 04:09:32 -0400
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 681C724000B;
        Tue,  7 Apr 2020 08:09:27 +0000 (UTC)
Date:   Tue, 7 Apr 2020 01:09:25 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Use case for EXT4_INODE_HUGE_FILE / EXT4_HUGE_FILE_FL?
Message-ID: <20200407080925.GA675720@localhost>
References: <20200406224534.GA668050@localhost>
 <20200407033031.GT45598@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407033031.GT45598@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 06, 2020 at 11:30:31PM -0400, Theodore Y. Ts'o wrote:
> On Mon, Apr 06, 2020 at 03:45:34PM -0700, Josh Triplett wrote:
> > Under what circumstances can an inode ever end up with EXT4_HUGE_FILE_FL
> > set? (Other than in an artificially constructed filesystem.)
> > 
> > Was EXT4_HUGE_FILE_FL just added for future extensibility, in case a
> > future file storage mechanism allows storing files bigger than 2**32
> > blocks?
> 
> Yes. basically.  When we added the huge_file feature, which introduced
> the i_blocks_hi field, the thinking was to add EXT4_HUGE_FILE_FL so
> that we could painlessly upgrade a file system from ext3 (w/o the huge
> file feature) to enabling the feature without having to rewrite all of
> the inodes.  However, we also didn't want to artificially limit
> ourselves to 2**57 file sizes, so we also added the EXT4_HUGE_FILE_FL
> flag.

Thanks for the explanation! That makes sense.

> It hasn't gotten a huge amount of testing in a while, but it would be
> relatively easy to add debugging code (triggered via a mount option or
> a sysfs file) which forces the use of EXT4_HUGE_FILE_FL all the time.

That does seem like a good idea. It would also be nice to have an e2fsck
option to rewrite all inodes to use EXT4_HUGE_FILE_FL.

I think I'll avoid poking that code for now, though, since I don't
currently have a need for files anywhere near that large.

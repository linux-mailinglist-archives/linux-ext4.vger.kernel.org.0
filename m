Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0070D12D168
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2019 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfL3PTc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 10:19:32 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48601 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727531AbfL3PTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 10:19:32 -0500
Received: from callcc.thunk.org ([173.239.199.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBUFJNjL026470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 10:19:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0A78D420485; Mon, 30 Dec 2019 10:19:22 -0500 (EST)
Date:   Mon, 30 Dec 2019 10:19:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, lixi@ddn.com, adilger@dilger.ca,
        dongyangli@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] e2fsprogs: fix to use inode i_blocks correctly
Message-ID: <20191230151921.GA125106@mit.edu>
References: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577705766-20736-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 30, 2019 at 08:36:06PM +0900, Wang Shilong wrote:
> blocks_from_inode() did not return wrong inode blocks, and
> ext2fs_inode_i_blocks() is not taking EXT4_HUGE_FILE_FL into account
> at all, while the some callers deal it correctly, some not. This patch
> try to unify to handle it in ext2fs_inode_i_blocks() to return.
> blocks(based on 512 bytes)

I don't really want to change the functionality of
ext2fs_inode_i_blocks().  First of all, it's in a shared library, so
if there are any binaries which were expecting the old behavior, that
could get surprising.  Secondly, its name is confusing and so we're
better off creating a new function ext2fs_get_stat_i_blocks() which
makes it clear that we function is using units of 512 byte sectors,
instead of either the file system block size, or the raw i_blocks
value from the inode.

Two other things about your patch.  First of all, the filefrag command
in debugfs was intended to print the number of file system blocks, so
it was correct as written.  Secondly, please note the blkcnt_t is a
signed type (because the block iterator functions use negative values
to indicate various kinds of metadata blocks), while blk64_t is an
unsigned type.  So using blkcnt_t as a temporary value and returning
it in a function which has a return type of blk64_t will (righly)
trigger compiler warnings.

Here's the patch I've checked into the maint branch of e2fsprogs to
address the issue you've identified.

					- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9B16EC6F
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Feb 2020 18:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgBYRYN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Feb 2020 12:24:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39879 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729817AbgBYRYN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Feb 2020 12:24:13 -0500
Received: from callcc.thunk.org ([4.28.11.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01PHNurB008220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 12:23:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1CA2A4211EF; Tue, 25 Feb 2020 12:23:55 -0500 (EST)
Date:   Tue, 25 Feb 2020 12:23:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jean-Louis Dupond <jean-louis@dupond.be>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Filesystem corruption after unreachable storage
Message-ID: <20200225172355.GA14617@mit.edu>
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
 <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 25, 2020 at 02:19:09PM +0100, Jean-Louis Dupond wrote:
> FYI,
> 
> Just did same test with e2fsprogs 1.45.5 (from buster backports) and kernel
> 5.4.13-1~bpo10+1.
> And having exactly the same issue.
> The VM needs a manual fsck after storage outage.
> 
> Don't know if its useful to test with 5.5 or 5.6?
> But it seems like the issue still exists.

This is going to be a long shot, but if you could try testing with
5.6-rc3, or with this commit cherry-picked into a 5.4 or later kernel:

   commit 8eedabfd66b68a4623beec0789eac54b8c9d0fb6
   Author: wangyan <wangyan122@huawei.com>
   Date:   Thu Feb 20 21:46:14 2020 +0800

       jbd2: fix ocfs2 corrupt when clearing block group bits
       
       I found a NULL pointer dereference in ocfs2_block_group_clear_bits().
       The running environment:
               kernel version: 4.19
               A cluster with two nodes, 5 luns mounted on two nodes, and do some
               file operations like dd/fallocate/truncate/rm on every lun with storage
               network disconnection.
       
       The fallocate operation on dm-23-45 caused an null pointer dereference.
       ...

... it would be interesting to see if fixes things for you.  I can't
guarantee that it will, but the trigger of the failure which wangyan
found is very similar indeed.

Thanks,

						- Ted

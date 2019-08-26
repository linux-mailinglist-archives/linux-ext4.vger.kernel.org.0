Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13D9C7E1
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfHZDTe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:19:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56418 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729378AbfHZDTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 23:19:32 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7Q3JQgL016295
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Aug 2019 23:19:28 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9736C42049E; Sun, 25 Aug 2019 23:19:26 -0400 (EDT)
Date:   Sun, 25 Aug 2019 23:19:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: attempt to shrink directory on dentry removal
Message-ID: <20190826031926.GC4918@mit.edu>
References: <20190821182740.97127-1-harshadshirwadkar@gmail.com>
 <20190824023110.GB19348@mit.edu>
 <CAD+ocbyrJDbUFtQdq087iJCc=41CNACeAA2U_KQG-B4w19Soqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyrJDbUFtQdq087iJCc=41CNACeAA2U_KQG-B4w19Soqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Aug 25, 2019 at 07:46:50PM -0700, harshad shirwadkar wrote:
> If last is an intermediate dx node, is there a way to find out if it
> actually is an intermediate dx node? Because an empty dirent block and
> an intermediate dx block look the same. Unless we do dx_probe() there
> is no way to know if a block is an intermediate dx block. Is that
> right or am I missing something?

You can simply look at the first hash value in the intermediate
dx_node (remember, an empty intermediate node is not allowed), and
then do a dx_probe to search from the root and validate that we find
our way back to the last block.

> Looking at your following comment, if metadata_csum feature is
> enabled, then we can distinguish if a block is an empty dirent block
> or an index block based on dentry->rec_len. If metadata csum is
> enabled, then for index blocks, fake_dentry->rec_len is set to
> blocksize while for a dirent not dentry->rec_len is set to blocksize -
> sizeof(ext4_dir_entry_tail). Is my understanding correct?

Yes.  Although even if the metadata_csum feature is enabled, it's a
good idea to search from the root to make sure this really is the
intermediate dx node block that you are looking for.  You need to do
the dx_probe() to find its parent block anyway, in order to update it.
And if you don't find a pointer to that intermediate node, then it
must not be an a dx node --- or the htree pointers are corrupted.  In
the case of metadata_csum and a dx_tail, that sequence should never
occur normally, so if you don't find an entry for that block when
doing a dx_probe(), it's likely the directory structures have gotten
corrupted.

						- Ted

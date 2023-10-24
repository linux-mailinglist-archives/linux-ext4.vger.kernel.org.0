Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8617D546D
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 16:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjJXOxs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Oct 2023 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjJXOxr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Oct 2023 10:53:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F9310D3
        for <linux-ext4@vger.kernel.org>; Tue, 24 Oct 2023 07:53:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C25C433C8;
        Tue, 24 Oct 2023 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698159224;
        bh=lUFQ3v5CpOWCmK337y0OntuNv8kN0NqIfQIZ92fiWus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CXhWXThuIDw9jKycAqBYeGO1zaSDEwHFFDU85loiH8gAoxWw5SqknD3YVaoS6JGqU
         a1ThKCAQvYu0jUzy/7hHQ98oDaBztYtGaw1pGrb/aydcCO8bgK3ABc+ILTZuZ0AZd8
         baKcazGQMt5RFzuENhwcElOglBDCbiCPld9XGvQA=
Date:   Tue, 24 Oct 2023 07:53:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
Message-Id: <20231024075343.e5f0bd0d99962a4f0e32d1a0@linux-foundation.org>
In-Reply-To: <20231024100318.muhq5omspyegli4c@quack3>
References: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
        <20231024100318.muhq5omspyegli4c@quack3>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 24 Oct 2023 12:03:18 +0200 Jan Kara <jack@suse.cz> wrote:

> On Mon 23-10-23 23:26:08, Hugh Dickins wrote:
> > Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
> > avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
> > allocations by GFP_NOWAIT allocations, I've occasionally been seeing
> > "page allocation failure: order:0" warnings under load: all with
> > ext4_sb_breadahead_unmovable() in the stack.  I don't think those
> > warnings are of any interest: suppress them with __GFP_NOWARN.
> > 
> > Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Yeah, makes sense. Just the commit you mention isn't upstream yet so I'm
> not sure whether the commit hash is stable.

e509ad4d77e6 is actually in mm-stable so yes, the hash should be stable.



Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9977D935
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjHPDp4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbjHPDpz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:45:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E41E1FCE
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:45:53 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3jhiC020214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692157545; bh=Y0lWEtstsKm4jJTExgGYLrxQQ4iSwZn679+W8fkAgRw=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Nu6fo24MQs2CZ70cNynW5wJocu+jb0S+GW6653dQfqn9pFnkE45819VvfjMnXN0NW
         vlmudo8XllNvHWad7K6VY/0zOzS1we948QJhNI8dvI7l31t3gLUq79mhtUsNmsLKcW
         L6iFc9YrkLjvcb8oLp9XO1f4CsUVNDhIQ0AhrTKIY/6l1iDBsWxFh9yuBepjhDrEGi
         LUwQw46DFlC5DiujAabfdH/DugRiibQ0HDaMVlg6iLh/5iMZTlIjfieKbEkG8QlSiF
         llFNwQpGfb/7l7Z9rX0C07E7O6frH7xdoUfgc4l6HOsSoorlMMqPzObLsENq8mT5bL
         xP0TiUjI0bJ3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 44FE415C0292; Tue, 15 Aug 2023 23:45:43 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:45:43 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
Message-ID: <20230816034543.GS2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-12-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:42PM +0800, Kemeng Shi wrote:
> In add_new_gdb_meta_bg, we assume that group could be non first
> group in meta block group as we call ext4_meta_bg_first_block_no
> to get first block of meta block group rather than call
> ext4_group_first_block_no for passed group directly. Then ext4_bg_has_super
> should be called with first group in meta group rather than new added
> group. Or we can call ext4_group_first_block_no instead of
> ext4_meta_bg_first_block_no to assume only first group of
> meta group will be passed.
> Either way, ext4_meta_bg_first_block_no will be useless and
> could be removed.

Unfortunately, I spent more time trying to understand the commit
description than the C code.  Perhaps this might be a better way of
describing the situation?

The ext4_new descs() function calls ext4_meta_bg_first_block_no() with
the group paramter when the group is the first group of a meta_bg
(e.g., when (group % EXT4_DESC_PER_BLOCK) is zero.  So we can simplify
things a bit by removing ext4_meta_bg_first_block_no() and an open
coding its logic.

Does this make more sense to tou?

					- Ted

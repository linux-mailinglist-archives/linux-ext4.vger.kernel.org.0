Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B166662D1
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jan 2023 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAKSbA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 13:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjAKSaY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 13:30:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990F233D68
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 10:30:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C6EF61D56
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 18:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57682C433D2;
        Wed, 11 Jan 2023 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673461821;
        bh=E8F1TYJUfPhYvJ807ETicuxzuXNnua/3NO0Wm9S/EQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJ2ORDT5rU4XO2JSRhOaPnjyVLg0iRor4WSmN3QwURezMadTA8q6bwi6spL9yNo6+
         dd88IgpHf5QkRRDBAm/0BT0V1RtL3WZlTbUSFb6x4n3zPdFb7keJWSpfoJVpkisA7v
         56R+l+cny75R8I1gVG7B4lyiwwk6lcpfaEsQ8aLl3KNIIV6gegx4WaILe3l4tj6+0z
         0IrXvdUJPXaRy/h1g47D92SabnmF59YLG46pDJad5XeVBI3ppzbamBoxkGkMQozLYr
         VYxiVC9DR9ND24zfvi5YZX4db96Zf6/1MrSn7s0DYo82uLfbPqedI26tS/BYc+f0HG
         EJnpJdhQj7Aeg==
Date:   Wed, 11 Jan 2023 10:30:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] ext4: use ext4_fc_tl_mem in fast-commit replay path
Message-ID: <Y78AO7WX5Q6Zju3p@sol.localdomain>
References: <20221217050212.150665-1-ebiggers@kernel.org>
 <20230111144327.gb6p3foqj23mby7w@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111144327.gb6p3foqj23mby7w@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 11, 2023 at 03:43:27PM +0100, Jan Kara wrote:
> On Fri 16-12-22 21:02:12, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > To avoid 'sparse' warnings about missing endianness conversions, don't
> > store native endianness values into struct ext4_fc_tl.  Instead, use a
> > separate struct type, ext4_fc_tl_mem.
> > 
> > Fixes: dcc5827484d6 ("ext4: factor out ext4_fc_get_tl()")
> > Cc: Ye Bin <yebin10@huawei.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Looks good to me. Just one nit below:
> 
> > -static inline void ext4_fc_get_tl(struct ext4_fc_tl *tl, u8 *val)
> > +static inline void ext4_fc_get_tl(struct ext4_fc_tl_mem *tl, u8 *val)
> >  {
> > -	memcpy(tl, val, EXT4_FC_TAG_BASE_LEN);
> > -	tl->fc_len = le16_to_cpu(tl->fc_len);
> > -	tl->fc_tag = le16_to_cpu(tl->fc_tag);
> > +	struct ext4_fc_tl tl_disk;
> > +
> > +	memcpy(&tl_disk, val, EXT4_FC_TAG_BASE_LEN);
> > +	tl->fc_len = le16_to_cpu(tl_disk.fc_len);
> > +	tl->fc_tag = le16_to_cpu(tl_disk.fc_tag);
> >  }
> 
> So why not just:
> 
> 	struct ext4_fc_tl *tl_disk = (struct ext4_fc_tl *)val;
> 
> instead of memcpy?

That would result in unaligned memory accesses.

- Eric

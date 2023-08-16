Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD577D8D7
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 05:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjHPDLA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjHPDKn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 23:10:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA594FE
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:10:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-114-154.bstnma.fios.verizon.net [173.48.114.154])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37G3AWGk005909
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 23:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692155433; bh=nURI5E/DZrdR7fRarRIW/CiWdEvE6/FY9zfas5SubA8=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=oG0uxozRGujMoO3B3sV5m8dMG6HKLRDmpOngzNoPMbWBji8ARiG+PfXo5RXlBYj11
         JRbVf3/VsKjCKkrodvG33n5FfPd4aWFMbzzqK8i1enqghU++5vysT3YIft7hoVimnt
         oTFoyAUi57JKG1KNPhXGWjweJ5ehkBRV4pNZ0bjkm0v9ZLDKXle76ly3urQLkNTOAO
         fdFPuTT1mytkbd71ScunqDoxouJEyIoSq7+hwNelYeglOK37lbIJ6a7j7FTxBLe8xA
         xS0U+Fx0nTTZL2lzLkkGl2+IeBUyMv75DmOnzoSrJLa/JpaxBkRMu1AxlgytYzp/fP
         Ua3c6v/GaGpog==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DC52215C0292; Tue, 15 Aug 2023 23:10:31 -0400 (EDT)
Date:   Tue, 15 Aug 2023 23:10:31 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] ext4: remove gdb backup copy for meta bg in
 setup_new_flex_group_blocks
Message-ID: <20230816031031.GL2247938@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-5-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629120044.1261968-5-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 29, 2023 at 08:00:35PM +0800, Kemeng Shi wrote:
> Wrong check of gdb backup in meta bg as following:
> first_group is the first group of meta_bg which contains target group, so
> target group is always >= first_group. We check if target group has gdb
> backup by comparing first_group with [group + 1] and [group +
> EXT4_DESC_PER_BLOCK(sb) - 1]. As group >= first_group, then [group + N] is
> > first_group. So no copy of gdb backup in meta bg is done in
> setup_new_flex_group_blocks.
> 
> No need to do gdb backup copy in meta bg from setup_new_flex_group_blocks
> as we always copy updated gdb block to backups at end of
> ext4_flex_group_add as following:
> 
> ext4_flex_group_add
>   /* no gdb backup copy for meta bg any more */
>   setup_new_flex_group_blocks
> 
>   /* update current group number */
>   ext4_update_super
>     sbi->s_groups_count += flex_gd->count;
> 
>   /*
>    * if group in meta bg contains backup is added, the primary gdb block
>    * of the meta bg will be copy to backup in new added group here.
>    */
>   for (; gdb_num <= gdb_num_end; gdb_num++)
>     update_backups(...)
> 
> In summary, we can remove wrong gdb backup copy code in
> setup_new_flex_group_blocks.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18E780503
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 06:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244123AbjHREIc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 00:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357790AbjHREIG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 00:08:06 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883EB210D
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 21:08:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37I47pWN003600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 00:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692331674; bh=AiNT7QOGDY9+Zpz8OEhMFokxY4nSOC+WNx+itR1GTXg=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=lZE6EuTKaAHS3iqoDeL8+J/sX7vYv2C6HNbU//T9Id/Cn49Kq/8f6jFCoM8JrOcL4
         9q7p/9ZwxdGkd4ayPZbaw5hsdLVh+LmX2H6LjVrSpeQgkhRbDVtb/NOPeb5xrkYm9W
         ngRS5r2relFGi9dEl475j9lLPnfz/1JF8AiDY1yVmioM++EF0vSgMhF20H1gvhG8eA
         deWmadsMs62a7sqPnSNjF7UqFNRqYQ1XoFPl9v1gNQt/YkcekxobLKwm+0DQ61/BA+
         VCRcGRY4Cu/2VN+MUpGAwvo5vPZ06o+8S3A/oO2fS+KtysrXSaZIiYsBGE8Jaalunq
         w9WrKdx/le3CQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7232E15C0501; Fri, 18 Aug 2023 00:07:51 -0400 (EDT)
Date:   Fri, 18 Aug 2023 00:07:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] ext4: correct gdblock calculation in
 add_new_gdb_meta_bg to support non first group
Message-ID: <20230818040751.GF3464136@mit.edu>
References: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
 <20230629120044.1261968-12-shikemeng@huaweicloud.com>
 <20230816034543.GS2247938@mit.edu>
 <29c9e94f-63b3-e757-9d6d-c9beaa0e0c19@huaweicloud.com>
 <20230817140328.GY2247938@mit.edu>
 <e9215048-8a10-bb3e-93f7-0bf840997027@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9215048-8a10-bb3e-93f7-0bf840997027@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 18, 2023 at 10:29:52AM +0800, Kemeng Shi wrote:
> Actually, there seems a functional change to add_new_gdb_meta_bg.
> Assume 'group' is the new added group, 'first_group' is the first group
> of meta_bg which contains 'group',
> Original way to calculate gdbblock:
> gdbblock = group_first_block('first_group') + bg_has_super(*'group'*)
> New ay to calculate gdbblock
> gdbblock = group_first_block('first_group') + bg_has_super(*'first_group'*)
> If new added group is not the first group of meta_bg, add_new_gdb_meta_bg
> get a wrong gdbblock.

If you look at the ext4_add_new_descs() function,
add_new_gdb_meta_bg() is only called when the group is a multiple of
EXT4_DESC_PER_BLOCK --- that is, when group % EXT4_DESC_PER_BLOCK == 0.

As such, it is only called when with group is the first group in the
meta_bg.  So there is no bug here.  The code is bit confusing, I agree
--- I myself got confused because it's been years since I last looked
at the code, and it's not particularly commented well, which is my fault.

This also makes the commit description "... to support non-first
group" incorrect, since it never gets called as with a "non-first
group".

The patch makes things a little simpler, but the commit description
would confuse anyone who looked at it while doing code archeology.
The change is fine, although at this point, given how we both
misunderstood how the code worked without doing some deep mind-melds
with the C code in question, it's clear that we need some better
comments in the code.

For example, the comment "add_new_gdb_meta_bg is the sister of
add_new_gdb" is clearly insufficient.

						- Ted

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5173EBA8
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Jun 2023 22:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjFZUR4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Jun 2023 16:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFZURZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Jun 2023 16:17:25 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA66E4
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 13:17:24 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-471b3ad20e1so1041811e0c.1
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jun 2023 13:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687810642; x=1690402642;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SKcrdBSkM8MYRQqsDhtbvkGn1p7TbA8H2miaLprsg8c=;
        b=NTUKf8AGs7KNMj9Id2Xy93Jh1RSlOOw7pRqIt9U5IwDZlnKv3pDykAhPlShCbqonLO
         9Bjv5WnfwxREZa0Nh5paXYALanu4HCP8vU7E8k/Acjc/8p8djqg6+WnlvNvOsjdqntj1
         vik0l2kySHmbzgWgeSAuje9iEqImTNQAYR6DWQaMfMpQTrxz3PW82iaF8IokcBWPj8UL
         ZyflohKdu7bE+jzPM5XmZPuiKuMwEC6Fo6L2SqhbWp68E0zq7Jmn08FuE+GVscbcEYQl
         SN86RmQc5y8+FVRRi0rs0F9YtyAnt23cHmJybCO7B7Rdk4JvMYqfl913nf4GZ04ekNKr
         Q8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687810642; x=1690402642;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKcrdBSkM8MYRQqsDhtbvkGn1p7TbA8H2miaLprsg8c=;
        b=dydzGGBSNxK6BhX771fEhtBqGS2TcGfBTe42eeW8fa8LocWCUHyImqQT1Xvz2NhUyP
         tfe4FtPav3+hr1tk1KOK/IiMbGpVrMKRiP5j3FZ8BPJt/ke0WhEwjb5D1pjeTH2dps2K
         aYkW49DF7mldp+EhuIOzYNlJ7hEJWlASTAXDsRHzPrt241+NiOqSs38a1Xr1THDq3i9E
         8ZUTyj50VgtO+PkdnIbWqcaWJa2wm5b0AXahimikwwK49ZOOl65eNB8Kf+qCob7NVwHO
         ZO4VzfoV01IWbpLtQ7fG4LNTe+uYBc9HefFptDStLAguidT1CpVuP2icS2//yISAEMb9
         w5bw==
X-Gm-Message-State: AC+VfDwU1v+c5zsUwb62QBD6syZd5Xmb78P+Tl++Sj0DsMCdj3k7qfxW
        nfn8rU6MvT1NOTXciHTW0UPBNlDBsQaiKOAkoPJbA/y97bQ=
X-Google-Smtp-Source: ACHHUZ4LkmP7YulLcVyA+0CArYKouUPiqtK8p8yvOnIU51tPRQuOKS+jVDmf2RQl2eBYLVb57GWLCbQzdi9iv1AaRPw=
X-Received: by 2002:a1f:d286:0:b0:471:be92:daa9 with SMTP id
 j128-20020a1fd286000000b00471be92daa9mr9226074vkg.13.1687810642068; Mon, 26
 Jun 2023 13:17:22 -0700 (PDT)
MIME-Version: 1.0
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Mon, 26 Jun 2023 21:17:10 +0100
Message-ID: <CAKbZUD01uR5kfP4=SSfQ111jKsfKi8ojfDZs5CStLD_h5qb5GQ@mail.gmail.com>
Subject: Question regarding the use of CRC32c for checksumming
To:     linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

(+CC the original author, Darrick)
I've been investigating (in the context of my EFI ext4 driver) why all
ext4 checksums appear inverted. After making sure my CRC32c
implementation was correct and up-to-par with other ones, I looked at
the fs/ext4 checksumming code, which took me to the implementation of
ext4_chksum in ext4.h (excuse the gmail whitespace damage):

>static inline u32 ext4_chksum(struct ext4_sb_info *sbi, u32 crc,
>       const void *address, unsigned int length)
>{
> struct {
> struct shash_desc shash;
> char ctx[4];
> } desc;

Open coding the crc32c crypto driver's internal state, seemingly to save a call?
>
> BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver)!=sizeof(desc.ctx));
>
> desc.shash.tfm = sbi->s_chksum_driver;
> *(u32 *)desc.ctx = crc;

...we set the starting CRC
>
> BUG_ON(crypto_shash_update(&desc.shash, address, length));

then call update, which keeps the current internal state in ctx[4]
>
> return *(u32 *)desc.ctx;

and then we never call ->final() (nor ->finup()), which for crc32c would do:
> put_unaligned_le32(~ctx->crc, out);

and as such get me the properly "inverted" crc32c I would expect.
FreeBSD never found this issue as their calculate_crc32c seems borked
too, and never inverts the result.

Is my assessment correct? Was ->final() never called on purpose, or is
it an accident? Or is this merely a CRC32c variation I'm unaware of?

I'd like to make sure I get all the context on this, before sending
any kind of documentation patch :)

Thanks,
Pedro

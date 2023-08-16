Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048977E520
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjHPP2H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344144AbjHPP16 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 11:27:58 -0400
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D3F1BE7
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 08:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692199672;
        bh=zbF8fMAIruRY+5EDhN5dKlKjIZ/LrmHaiop+HK7FHDo=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=kE7vWtHMgt3d+8wIq+M02o41JUeeLI5bWEgl4z9rna8HReTIbWBklo1cZYdOLCdnM
         nEcMHMIfilUk3mX64dwS8xtQX10HPUEE++MRe+XwFNfPpnbnc31XZtvzAQmRoTjNa3
         /WkKNHNr8btDLyVIdM3rGseaB7fZuCwdl1wuistk=
Received: from [IPV6:2409:8a00:257c:3c10:acee:d1ea:2796:2974] ([2409:8a00:257c:3c10:acee:d1ea:2796:2974])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 6F39A402; Wed, 16 Aug 2023 23:27:51 +0800
X-QQ-mid: xmsmtpt1692199671turf9b6sq
Message-ID: <tencent_C6168D4951510CC689A5A7750F17446DD905@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnTOn8+ItzKbE7t0/z9Z7o3kStYLWJzOrYgGKua3I82pnIvXKq4n
         NAZBuj5OsrEahGyWGEXSm4d11nPjO3E7mcMq/XtKZ6M6Fi9HqISlKOS536EU/IXxrCnPomeYpACu
         Ddw9s1hoVtnlR0kaQH0UwYXhj8obTd7ALKZ98bBQCFeHVWKroT4YWrdJFNZWoSlfqwQCdk/l8iBV
         CEqLxI0RPz/OYKzrkgHHYQpdKXex91KMPu3xCu0F9nGYmaO0b83X5OMYkmMzC8d32nwIcaOHJqAj
         q2VQfJFe9gIn9b/tGEoaUeky077sLS31MV7vXRGrNf2qVB1NF44w2xLYkNIkPa628c/j55J0TyFO
         dN9IQVROw6n67q+38nxnr9EBXV0g18ueGfpoequrzFt+dhOA1o51e2Ot0vBuSgY961FWdmZjEJ+w
         Tu6AxP+79vV1y+XEi0ZUGfVrmYXbVYQibwrcgmHmyfW0DJ+HQub119Lkm7YgF7HXnR4CxwpH/vFc
         xI5YroU2A+w0HQpwN4aqJtEr7hjkpAxMKxf9QIWbLFs4hmjDYecJnv3A0Wf/pXtjs64V42BjHJa0
         X15OvOEB/oNlR/BkP+ckueWAz/RLTKf4QKyCXQ5+sdSdcDiSV6pxVud8+OrZhfz6wbnrZjPX/ZSt
         jnjl2wtdHwE/6XAYBZIZL4dvcP8WZTRC8ZgM5Qo+/cqU9aHWR+IYJARbgScJ6Lsnt0cnvWNVd1UJ
         4vr7hvV7DvyAvKesSSPVIqhYx2SJU/70i2eYKfhQFmBjWVwiYhobaZiO4z+c8AXVBjvqeyPZfqJw
         2gdQNvvQUTTOJt2CMopyAxR5IOZMyB8uhP7daJ9OpX+a0t249IYwHQiyx/x+oG/OpxZhubmEfBzA
         KciuLXwetwWV+jfqmcZ7Bpw4WcH4OvUE1Ae7Iw0xpf113kgW3aPrLCdpnw6+WYjzZ/uBJuS+5Yvc
         fKQQrdjhBnJlIvZk+L23lww+MGzfctsL4FJ/RdTgM=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-OQ-MSGID: <1bc68f43-a96e-5369-3c3e-475e8f0631c2@foxmail.com>
Date:   Wed, 16 Aug 2023 23:27:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] ext4: Add correct group descriptors and reserved GDT
 blocks to system zone
Content-Language: en-US
To:     linux-ext4@vger.kernel.org
References: <20230802162840.331385-1-wangjianjian0@foxmail.com>
 <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
From:   Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <tencent_D744D1450CC169AEA77FCF0A64719909ED05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,
Any comments?

On 8/3/23 00:28, Wang Jianjian wrote:
> When setup_system_zone, flex_bg is not initialzied so it is always 1.
> ext4_num_base_meta_blocks() returns the meta blocks in this group
> including reserved GDT blocks, so let's use this helper.
> 
> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
> ---
>   fs/ext4/block_validity.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 5504f72bbbbe..558e487a0b53 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -215,7 +215,6 @@ int ext4_setup_system_zone(struct super_block *sb)
>   	struct ext4_system_blocks *system_blks;
>   	struct ext4_group_desc *gdp;
>   	ext4_group_t i;
> -	int flex_size = ext4_flex_bg_size(sbi);
>   	int ret;
>   
>   	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
> @@ -224,11 +223,11 @@ int ext4_setup_system_zone(struct super_block *sb)
>   
>   	for (i=0; i < ngroups; i++) {
>   		cond_resched();
> -		if (ext4_bg_has_super(sb, i) &&
> -		    ((i < 5) || ((i % flex_size) == 0))) {
> +		unsigned int meta_blks = ext4_num_base_meta_blocks(sb, i);
> +		if (meta_blks != 0) {
>   			ret = add_system_zone(system_blks,
>   					ext4_group_first_block_no(sb, i),
> -					ext4_bg_num_gdb(sb, i) + 1, 0);
> +					meta_blks, 0);
>   			if (ret)
>   				goto err;
>   		}
> 


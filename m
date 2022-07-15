Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A570B57643C
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiGOPOe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 11:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiGOPOd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 11:14:33 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jul 2022 08:14:31 PDT
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B8BB8
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1657898069;
        bh=QXjGMiIOWyMCcQ2G5GQhhgyU7u0/1yl5SRfU0UEbqaM=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=obO37BHOdRsMDArKrGDfYXmlaHSXPyaHFsCjSvpmuc6OcU6UvNsxVaZX5jnaAKv9L
         z+3oqoV+AsEKrsL01p9hsnxHhqcJgjhXPeoObrcOj/U9Bw6TwH0y1uxxgTHxVZLJ/C
         LUdrZCH64HUaJRG1gjKSg+wVRCPIpsZ2iwvWIB3g=
Received: from [192.168.50.235] ([123.112.69.211])
        by newxmesmtplogicsvrsza32.qq.com (NewEsmtp) with SMTP
        id 2D7BB450; Fri, 15 Jul 2022 23:11:23 +0800
X-QQ-mid: xmsmtpt1657897883tn16lfu5w
Message-ID: <tencent_8CDB89A1076C8F0FE46F79120D40114BAC05@qq.com>
X-QQ-XMAILINFO: MVbvI5amSZ2YmAhZp7QRDsPBGq1BojgM8W64VwLO4pEcHTFEQmfPru5iv4mkJE
         4T1u/Iq8Qs+MH7OnFg9xNyWZNFtfBwS3OtsYJuRxjmsCTPjkchTKQz0k/sx9vkdn9mWzB6gIp/Ee
         bzPRsHNj5dr7WIRKn7f4jlf0nqD2uaKa1/xoOYsA5KGnNtxGDz1zCaNm6YMhz9WyW7CNCW2sQhWj
         z20vsFMBdoFo7HFET5HlrMHmsb06T5bDRcFA5+/gePXAmwNLZ17MNGRhusebEeMQsvvUzpiVdO72
         1UlyXPx8nNQUoXEqjjaOcQx7j7GPIEhSJb+UW/r+H0p7nvhxl7XkHOxFM147WqC3lBPLmvmB1cqz
         d/Ja8zkCgl5vsinbPcOPEA0BHj6tUQq7jbbIeyI1n+OdMKrG9yRyJI6MQYq3sGZ/81lGeuAv7izz
         TJochsW9xr3VlL0CrdXJ69rsJkbaQttE9IFrbQyM830UcBg2RWqbhxkKBkE2lxQeq6/I3YyV2m1M
         0KE5chXXrJE/bZhwqwCFlH+msxcld/hLEuBqP//taCBZx458CTJdcDcFFpO7NXI/+pX3S1HkX0gg
         JyaxSKrg73/yHPRTZj4gvxgecTKghlUAqsgwXrv4oi1QzS8yK/YJnqGQq5UtehyiF3ktqop3O+Yu
         5ApFeYAsDD69BA0xXEMh1FGEkF9/1GmC5iqJNpgkB1zX1jvijf7sRZu7iwxkvy86/x9E7JOys/s7
         yDkue5Uo34bAJ+vNOywWD3iDWFWvF7+8jHxvY31C19Y6u35knlnVFKj4ZZSg3fw5/c9Aws1SQhyh
         9nkG/+z5OeKw9K4dUJpEsj+KIRJ+JxI5mKZ4nj/J8FLbHgHIbo6TIThfqf3Pi7TAMG6qVpVrzx8w
         6MQME9sW85IFkExvo+sQiiaj3bCC5LgypDP8yqVmIeQQI7OTnn9QfX2VUtZ2ww1B7fpJzzeWn7Zf
         U4lkXUqDU=
X-OQ-MSGID: <3e05cb40-a7fd-ee8e-eb22-c961da7796dc@foxmail.com>
Date:   Fri, 15 Jul 2022 23:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] jbd2: Set the right uuid for block tag
Content-Language: en-US
To:     linux-ext4@vger.kernel.org
References: <tencent_D668868A37626B4E053D6D7B5320DBCB1C08@qq.com>
From:   Wang Jianjian <wangjianjian0@foxmail.com>
In-Reply-To: <tencent_D668868A37626B4E053D6D7B5320DBCB1C08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,
Is this a real problem need to fix ?

On 7/12/22 00:26, Wang Jianjian wrote:
> journal->j_uuid is not initialized and let us use the uuid from
> j_superblock. And since this is the only place where j_uuid is used
> so that we can remove it.
> 
> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
> ---
>   fs/jbd2/commit.c     |  2 +-
>   include/linux/jbd2.h | 10 ----------
>   2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5b9408e3b370..efde9c494e7a 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -720,7 +720,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>   		bufs++;
>   
>   		if (first_tag) {
> -			memcpy (tagp, journal->j_uuid, 16);
> +			memcpy (tagp, journal->j_superblock->s_uuid, 16);
>   			tagp += 16;
>   			space_left -= 16;
>   			first_tag = 0;
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index de9536680b2b..9d51f4b55cb5 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1079,16 +1079,6 @@ struct journal_s
>   	 */
>   	tid_t			j_commit_request;
>   
> -	/**
> -	 * @j_uuid:
> -	 *
> -	 * Journal uuid: identifies the object (filesystem, LVM volume etc)
> -	 * backed by this journal.  This will eventually be replaced by an array
> -	 * of uuids, allowing us to index multiple devices within a single
> -	 * journal and to perform atomic updates across them.
> -	 */
> -	__u8			j_uuid[16];
> -
>   	/**
>   	 * @j_task: Pointer to the current commit thread for this journal.
>   	 */
> 

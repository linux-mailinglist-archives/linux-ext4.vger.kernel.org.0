Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E0550807
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Jun 2022 05:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiFSDWB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Jun 2022 23:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiFSDWA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Jun 2022 23:22:00 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F160B1F5;
        Sat, 18 Jun 2022 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=goKrB
        IipxbQydneqcbSq79IAVaJ8AkLf0bgF7uVsW/U=; b=g2eld5DZJqT1CLdqSZJeC
        NmotrBB6hBr0BzPeUselrIML92iPYOsbmy6OKxKsmdaibe0hxlKnUN3z5tG2ucOX
        uAUa+K4OYrc6rBpvzkAhzesftAd8214sqFLX+6KstnrpLe0OkqAD5VBjYLTstuLg
        UoEIrX5IYwk0pjsdXZdELY=
Received: from [192.168.2.4] (unknown [106.120.30.143])
        by smtp7 (Coremail) with SMTP id C8CowACnHYU3lq5iq3xqIw--.31619S2;
        Sun, 19 Jun 2022 11:21:28 +0800 (CST)
Message-ID: <c19b8c8f-7c0f-33e6-3f2c-3425dee7fa8d@163.com>
Date:   Sun, 19 Jun 2022 11:21:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] ext4: page-io: use 'unsigned int' to bare use of
 'unsigned'
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220518120137.2544-1-liupeibao@163.com>
 <YqtDEfJd5uUxucaS@mit.edu>
From:   Liu Peibao <liupeibao@163.com>
In-Reply-To: <YqtDEfJd5uUxucaS@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C8CowACnHYU3lq5iq3xqIw--.31619S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUc1v3UUUUU
X-Originating-IP: [106.120.30.143]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbBaRglbFXlyP-tcwAAsh
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2022/6/16 22:49, Theodore Ts'o wrote:
> On Wed, May 18, 2022 at 08:01:36PM +0800, Liu Peibao wrote:
>> Fix warnings by checkpatch.
>>
>> Signed-off-by: Liu Peibao <liupeibao@163.com>
> 
> Please don't send checkpatch-only patches.
> 
> Thanks,
> 
> 						- Ted

Hi Ted,

Thanks for your reply. What I want do to is rename some temporary 
variables in the patch2 and when I make the patch, there are the 
checkpatch warnings. From the point of view "one patch do one thing", I 
split the modification into two patches. Thanks!

Best Regards,
Peibao


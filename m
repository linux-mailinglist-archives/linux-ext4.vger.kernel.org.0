Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623AF2956D5
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 05:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444081AbgJVDd5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 23:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443991AbgJVDd5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 23:33:57 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04275C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 20:33:57 -0700 (PDT)
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 509712E0DB8;
        Thu, 22 Oct 2020 06:33:54 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id hyUqnPa8Kv-XsxmSpfa;
        Thu, 22 Oct 2020 06:33:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603337634; bh=UYzaDSpCnGad0qx+ZtxBD8A1Cg/l14jvs8FhdCCfQQ8=;
        h=Message-ID:In-Reply-To:Subject:To:From:References:Date:cc;
        b=og02zOV48BNS8Z6qGPbASGtsQMD+4j8aK8IrTMlHkEGU3w9Xcq0gIqh02itke4I3m
         YQefkrYFs9S2UFTitjdxwD5Q4lcTLaW4d4dTeUeTVUepGoVqTZJi8lJTzd9peOezBD
         jk7AdgFIpCN3Awz6vC0h5goXCTIshcntvTeVqVug=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:416::1:0])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id XruiuOS3fG-XrnSQb3q;
        Thu, 22 Oct 2020 06:33:54 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Thu, 22 Oct 2020 06:33:53 +0300 (MSK)
From:   Roman Anufriev <dotdot@yandex-team.ru>
X-X-Sender: dotdot@dotdot-osx
To:     Jan Kara <jack@suse.cz>
cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        dmtrmonakhov@yandex-team.ru
Subject: Re: [PATCH v2 1/2] ext4: add helpers for checking whether quota can
 be enabled/is journalled
In-Reply-To: <20201019095328.GE30825@quack2.suse.cz>
Message-ID: <alpine.OSX.2.23.453.2010220629560.1375@dotdot-osx>
References: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru> <20201019093706.GC30825@quack2.suse.cz> <20201019095328.GE30825@quack2.suse.cz>
User-Agent: Alpine 2.23 (OSX 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 19 Oct 2020, Jan Kara wrote:

> On Mon 19-10-20 11:37:06, Jan Kara wrote:
>> On Sun 18-10-20 05:02:26, Roman Anufriev wrote:
>>> Right now, there are several places, where we check whether fs is
>>> capable of enabling quota or if quota is journalled with quite long
>>> and non-self-descriptive condition statements.
>>>
>>> This patch wraps these statements into helpers for better readability
>>> and easier usage.
>>>
>>> Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
>>
>> Looks good to me. You can add:
>>
>> Reviewe-by: Jan Kara <jack@suse.cz>
>
> Now I've realized that if we run in nojournal mode, quota won't be
> journalled in any case. Probably not a configuration you run in but still
> we should get that right.

I forgot about this case. Fixed in v4:
https://lore.kernel.org/linux-ext4/1603336860-16153-1-git-send-email-dotdot@yandex-team.ru/

 								Roman

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC349288F24
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbgJIQr1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 12:47:27 -0400
Received: from z5.mailgun.us ([104.130.96.5]:30457 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbgJIQr0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 12:47:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602262046; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=R6nMem/qqKWaoZGmM9A/xjfe5EOsaO5tzupufqDbRbo=; b=OSZYDPoRcjPZUGUP+O3GdLcfQaGeTUZ+VQKio66o6UlcKqZtzNHrx8nEuZvQht1aVVEcI0WU
 IH1ajB9AvVESOLNPjxsUPjk4DZYzzDzXwgYd/VOyKCQykoG3ECJBptXyUVEwDE5lj4ml3Lc1
 JCFjo/cLTibGaHKwybBKxBJwHbM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyIzYTlkNCIsICJsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f80940c588858a304b0e8d2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 16:47:08
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44481C433FF; Fri,  9 Oct 2020 16:47:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4EBCEC433C9;
        Fri,  9 Oct 2020 16:47:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 09 Oct 2020 09:47:06 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question regarding ext4_journalled_aops: lack of migrate_page
In-Reply-To: <4296a311893a9173e6ba8b84a8ae16f4@codeaurora.org>
References: <4296a311893a9173e6ba8b84a8ae16f4@codeaurora.org>
Message-ID: <5c68c087a39752370f9f4bbea8b2e769@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

tOn 2020-10-08 23:42, Chris Goldsworthy wrote:
> Hi there,
> 
> ext4_aops and ext4_da_aops both have a migratepage callback, whereas
> ext4_journalled_aops lacks such a callback.  Why is this so?  I’m
> asking this due to the following: when a page containing EXT4 journal
> buffer heads ends up being migrated, fallback_migrate_page() is used,
> which eventually calls try_to_free_buffers(), which will call
> drop_buffers().  Drop buffers() can fail for a page if that page is on
> the LRU list (see
> https://elixir.bootlin.com/linux/v5.8.14/source/fs/buffer.c#L3225).
> Now, if buffer_migrate_page() was supplied as the migratepage callback
> for the journaled aops, this wouldn’t be problem since we ignore the
> LRU lists altogether.
> 
> Resolving this issue will benefit CMA allocations, which might have to
> migrate movable pages that were allocated from a CMA region (the
> assumption is that these pages can be migrated once the memory backing
> these pages is needed).
> 
> Thanks,
> 
> Chris.

An alternative solution to to placing in a migratepage callback is to 
actually remove the buffer heads from an LRU list in drop_buffers() - we 
tried upstreaming such a patch some time ago: 
https://lore.kernel.org/patchwork/patch/325406/ .  This would solve the 
problem, and would avoid having to get a migratepage callback for any 
other files systems that have aops without the callback.  This didn't 
get off the ground however, I'm picking up the line of questioning left 
in the previous thread, to determine why EXT4 doesn't have a migratepage 
callback.

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

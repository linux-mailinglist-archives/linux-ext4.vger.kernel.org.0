Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0D2882D4
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Oct 2020 08:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgJIGma (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Oct 2020 02:42:30 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:46771 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgJIGm3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 9 Oct 2020 02:42:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602225749; h=Message-ID: Subject: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=eER3nzhN0ecfxmrTvJRASoFkdXeq9f/HfxlK3q45SPI=; b=shRA3wrJ7OELYPbrKU15kSxLAlxg///SayzXRYgvaF+q6vuqsIditSe7sWVR7r24HstHTEf6
 CqEPoIKSCAZAfOYC9BvOZG9ESVJ+eQOO+vZ0Why9sHyfqzIOcGiGB2SsfP0IHjbCAxLsvORO
 BLA/NwFMDKsaobknsnJJZfGWabE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyIzYTlkNCIsICJsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f80064952f4fccef02758d5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 06:42:17
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 30571C433CB; Fri,  9 Oct 2020 06:42:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 519ADC433FE;
        Fri,  9 Oct 2020 06:42:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 08 Oct 2020 23:42:16 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Question regarding ext4_journalled_aops: lack of migrate_page
Message-ID: <4296a311893a9173e6ba8b84a8ae16f4@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi there,

ext4_aops and ext4_da_aops both have a migratepage callback, whereas 
ext4_journalled_aops lacks such a callback.  Why is this so?  I’m asking 
this due to the following: when a page containing EXT4 journal buffer 
heads ends up being migrated, fallback_migrate_page() is used, which 
eventually calls try_to_free_buffers(), which will call drop_buffers().  
Drop buffers() can fail for a page if that page is on the LRU list (see 
https://elixir.bootlin.com/linux/v5.8.14/source/fs/buffer.c#L3225).   
Now, if buffer_migrate_page() was supplied as the migratepage callback 
for the journaled aops, this wouldn’t be problem since we ignore the LRU 
lists altogether.

Resolving this issue will benefit CMA allocations, which might have to 
migrate movable pages that were allocated from a CMA region (the 
assumption is that these pages can be migrated once the memory backing 
these pages is needed).

Thanks,

Chris.

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project

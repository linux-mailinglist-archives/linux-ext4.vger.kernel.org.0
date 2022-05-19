Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9A52D174
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiESL1r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiESL1q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 07:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF837A30
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 04:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7B161B20
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 11:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3AAC385AA;
        Thu, 19 May 2022 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652959664;
        bh=iNoDGxMLFdCDEbqbHZkAgsEP87xmldbX8bJVs3NNCrM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bT/ZvvJu+Th5l6pSJFTdweeI/hxLMTlzS2tUOINtFItCLBLP7G8NG4A5sB/y3owyY
         uqWQ1jdzvrytm4bX/PgDBRPzSIff95didQBB+SBJkpYEnnkKzGSRtFJiNszTs0dol0
         r/RO8RhneotCU2Q3d/bYKzDZPscY6qCLifmV85z85m/i3FDLQjsh2hF6DI8kLJ5f1d
         bk7JfChyQNtq88H4XlwNJYdz4dSTC4BQlyVIPq6PoIPEioMJwPzNCW3+DRUIcO4Tlm
         yUiI0RZLgR6tCgIfWg8xOq6ucXbugJr+sSzWp4lvgdDCHqnws4blstgm+6QziZfuSe
         h3ba38yO0EyAg==
Message-ID: <fb8aaa09-7bfd-7e2a-4cb1-de691fdb6408@kernel.org>
Date:   Thu, 19 May 2022 19:27:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v5 2/8] f2fs: Simplify the handling of cached
 insensitive names
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-3-krisman@collabora.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220518172320.333617-3-krisman@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/5/19 1:23, Gabriel Krisman Bertazi wrote:
> Keeping it as qstr avoids the unnecessary conversion in f2fs_match
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

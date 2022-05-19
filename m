Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6563352D184
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiESLct (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiESLcr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 07:32:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A5A5A85
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 04:32:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98F5AB823E2
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 11:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA442C385AA;
        Thu, 19 May 2022 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652959964;
        bh=1n+/a9vU24s3NevaoyfnBZGBKnGFH0VWAkQ5iWSSV00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PfC+jIYoVcvbOzUv/x+k5HwhStSv2URYAiPX8UZjabwkzrl4Vxc13s2S2Pmg5YKiK
         5hBDuklY1QGOnS3fxLitjCQdUVQQl1uzN8htchnoCMF1o0xwi0XYCqTc1ecTVA5UMR
         wQ69du0f2XNME1fUhOYptYLZPwVd4xHYwHDU+fTv0n6AHuOYOpAfGFS0cRcXpvCVk7
         AFRg5geNcGkimCGvYqm/X0aR/nA6CYzO0rXsswZDoetg+AWM2FdbVihDPq1Y0HhX84
         PsrmCY13MTiuUR8sAYTzQR7TtVSX5X2s1a27I5UR0cAuMKNUmBEXFlB8yeUJr5+xvQ
         kZdBj+hD4nvoQ==
Message-ID: <8f48a9f7-f48a-0f2a-976d-3e9513a6c97e@kernel.org>
Date:   Thu, 19 May 2022 19:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v6 5/8] f2fs: Reuse generic_ci_match for ci
 comparisons
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-6-krisman@collabora.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220519014044.508099-6-krisman@collabora.com>
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

On 2022/5/19 9:40, Gabriel Krisman Bertazi wrote:
> Now that ci_match is part of libfs, make f2fs reuse it instead of having
> a different implementation.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

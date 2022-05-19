Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDA52D18F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 13:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiESLfI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 07:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiESLfI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 07:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E2B0A66
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 04:35:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E15261B20
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 11:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A02C385AA;
        Thu, 19 May 2022 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652960105;
        bh=l+UvfwWDbzIpNOrWxSKX1teRaSjmc4rzDjynn+J1lAA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XJRqYvIKuODj6ZGJfUdZPj+xNEUlH9X7Rsdu7MQIxDCHfh3Z02y1Zg0BpdvqZTdmf
         xs27fBxE6B525tsNCbWFlYqzWUZPiZ+n6kaAKfH4nq9GAFk0RV8i2bP5TtaWjOkFzm
         9bM5AEKqAkJ63FXMIyIJ+nOuY8APGA3v0nafC0xBoJ67iNbTsyYP/eWpx59r4BGSnW
         W6XBT02DW7CAXPU6x/xuYQLQgpUUohMr5QqNoBwEKpTznubV1s3l1IDFvrIt1cqwst
         vKiYeI4UzZo56NC8yVdLyMW4PWdH0i6ELDocLb603EzzTvDlh6H16RT6S9Cp++HLpc
         F4eXZ7w7YuVGw==
Message-ID: <893fcc14-6cda-ce2b-222c-2c48bf2275d2@kernel.org>
Date:   Thu, 19 May 2022 19:35:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [f2fs-dev] [PATCH v6 8/8] f2fs: Move CONFIG_UNICODE defguards
 into the code flow
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        Eric Biggers <ebiggers@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-9-krisman@collabora.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220519014044.508099-9-krisman@collabora.com>
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
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

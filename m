Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA43352CA87
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiESDoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiESDom (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 23:44:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBA6E8E1
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 20:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FEBB822B7
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 03:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA65C385B8;
        Thu, 19 May 2022 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652931878;
        bh=ekh/FhP84EQQVSkLScUnt4yyZGY4hkjplyJ/xocL9Jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXm2YlpG7htAqF1Rk3DrkQ3sJ+UeugX93urKrVYxjBOc70gNVgh15hdDq+5V6i0of
         X7vWv7wSB9llWvwr+1C3HRBobnAWUowMjIN457pcHV28CMpOsljpEjTx4g3jxg/4hn
         Rituwib+6Tbdl15AWSG3E6MdB4M+D0uifztwKybUzZQfVhaa7vmD6JFWT8kgTNHuhY
         BIa8mUprBeF+cdQIiUxGOoGBy0vLuArKskMFSvgKEcwQfS7zoo/Z54pgwC0aorG/Gi
         8W4eZWvPNlpPfdSUEpjrzwjMhmxdu9cjYX+PL6sRO9Zdgv1odkClvot+0+uN5h0b3j
         CjZr6ZdHb+NDw==
Date:   Wed, 18 May 2022 20:44:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v6 7/8] ext4: Move CONFIG_UNICODE defguards into the code
 flow
Message-ID: <YoW9JEvePQFMQXeR@sol.localdomain>
References: <20220519014044.508099-1-krisman@collabora.com>
 <20220519014044.508099-8-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519014044.508099-8-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 09:40:43PM -0400, Gabriel Krisman Bertazi wrote:
> Instead of a bunch of ifdefs, make the unicode built checks part of the
> code flow where possible, as requested by Torvalds.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v5:
>   - Drop err variable (eric)
> Changes since v4:
>   - Create stub for !CONFIG_UNICODE case (eric)
> ---
>  fs/ext4/ext4.h  | 47 +++++++++++++++++++++++------------------------
>  fs/ext4/namei.c | 15 ++++++---------
>  fs/ext4/super.c |  4 +---
>  3 files changed, 30 insertions(+), 36 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7431752C336
	for <lists+linux-ext4@lfdr.de>; Wed, 18 May 2022 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbiERTWT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbiERTWS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 15:22:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0E149142
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 12:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 099CBB821AB
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 19:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61601C385A9;
        Wed, 18 May 2022 19:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901734;
        bh=0+oMuruS0sybzmrAJPzSrVZVn2r9i/tfi5shtNvvpsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pjHa5ap0uLs0/1n0HK/MwQCGLa1+8/F9cWHUjlCrXlmxz8uHR1EU4KGF4uRUKZ3JK
         +G0NK4CeQe52Pzaxdl2XbwRSgdjfWS0PyMLfsv+yVheIuIszYnNThCtlQ/Vl2TolLJ
         KA47kkBGyp3QEK+KGp1tkp4GJ5oYtwEMLa+I4O4lxhOmbo9VpgDcA88pmn9t4s8uNV
         +5AUFFxIZL6cYxzn0K0Sq5/k2TqlpTpQe05Cv9B/UNW7b2MofmH7JfSFzID+abA373
         GYArZ9YmIQmvVMNsqZut6D9XHLNeoOcoXh1jtkmk2W0f09MqakPdvWNNO8QQBIcKJR
         T8Gbm2oMLv6Zg==
Date:   Wed, 18 May 2022 12:22:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 5/8] f2fs: Reuse generic_ci_match for ci comparisons
Message-ID: <YoVHZGUKxqPOLU+v@sol.localdomain>
References: <20220518172320.333617-1-krisman@collabora.com>
 <20220518172320.333617-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518172320.333617-6-krisman@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 18, 2022 at 01:23:17PM -0400, Gabriel Krisman Bertazi wrote:
> @@ -277,8 +225,10 @@ static inline int f2fs_match_name(const struct inode *dir,
>  
>  #if IS_ENABLED(CONFIG_UNICODE)
>  	if (fname->cf_name.name)
> -		return f2fs_match_ci_name(dir, &fname->cf_name,
> -					  de_name, de_name_len);
> +		return generic_ci_match(dir, fname->usr_fname,
> +					&fname->cf_name,
> +					(u8 *) de_name, de_name_len);
> +

There's no need for the cast to '(u8 *)'.

- Eric

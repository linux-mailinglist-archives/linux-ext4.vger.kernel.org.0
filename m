Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E12956AC99
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbiGGUQ1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236411AbiGGUQ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 16:16:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8B6205E4
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 13:16:26 -0700 (PDT)
Received: from localhost (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: krisman)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D94C866019C8;
        Thu,  7 Jul 2022 21:16:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657224985;
        bh=9KVTq+598AWBgquU3L+2OS2TTSqIfcRAlrdcoQsFS3I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U0fXOFvuKxaTP/F6v9VQI31fch3r5atUGYsGMk8a7ynNCAx/6KHqBcUVmY6XXefIj
         IBZNTdxcTfa8HFuX7iYa3tbvaRMCwkX/WvhfyUji+za9ZG6C7CekBYRjnCiVc6LYSD
         lhvPAm4dm/piyeYwO+/ylWXzmVZmBT9P7fG73mNHXrvtv+vrKqddoXblhp2Dnroxmb
         5aseBIiGM8i9F6c9adZc0VDfHu5BN5IbO17ftuNwsGmv4JeTZ4id/QVwUUGyr3uQ9X
         F6o2Yzbo9g+dL5YqFmrktdGGV7bOL+Brgel7BfHv1bfTcUKXn28s922zQ1ooH1N7Q0
         KlnhJZX/V/OMA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Slava Bacherikov <slava@bacher09.org>, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] tune2fs: allow disabling casefold feature
Organization: Collabora
References: <YscmTC3Mk9OXqOgL@gmail.com>
        <20220707190456.64972-1-slava@bacher09.org>
        <Ysc5HYPXUs6rW02S@gmail.com>
Date:   Thu, 07 Jul 2022 16:16:21 -0400
In-Reply-To: <Ysc5HYPXUs6rW02S@gmail.com> (Eric Biggers's message of "Thu, 7
        Jul 2022 19:50:53 +0000")
Message-ID: <87tu7s3ch6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, Jul 07, 2022 at 10:04:56PM +0300, Slava Bacherikov wrote:
>> +	if (FEATURE_OFF(E2P_FEATURE_INCOMPAT, EXT4_FEATURE_INCOMPAT_CASEFOLD)) {
>> +		if (mount_flags & EXT2_MF_MOUNTED) {
>> +			fputs(_("The casefold feature may only be disabled when "
>> +				"the filesystem is unmounted.\n"), stderr);
>> +			return 1;
>> +		}
>> +		if (has_casefold_inode(fs)) {
>> +			fputs(_("The casefold feature couldn't be disabled when "
>> +					"there are inodes with +F flag.\n"), stderr);
>> +			return 1;
>> +		}
>> +		enabling_casefold = 0;
>
> Likewise, "couldn't" => "can't".
>
> Also, what are the semantics of disabling casefold, exactly?  Do the encoding
> and encoding flags fields in the superblock also get cleared?

The kernel is able to ignore the non-zero encoding field if the feature
is not set, but we definitely don't want to rely on that.  The patch
should explicitly zero both s_encoding and s_encoding_flags.

-- 
Gabriel Krisman Bertazi

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C252DDFA
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 21:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiESTwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 15:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiESTwR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 15:52:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E34C57167
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 12:52:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 593FA1F45F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652989934;
        bh=VomzjzzCFyvyKndjLIaMric6uaiVW6aQWxQEa6yjllU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mAh/bLJUBl1G654LVZymUzj4D2nRiO5B7TzDI9MKL5pot6CI3nO9Z/2MErbEV6U6i
         3t0Vv5p0dqbf+3ndgIvNBIUh5EdMVZFPPyQlcYF+wtGS114BZ/aa31rWBOm7SfE+ES
         TTZZPb5XI6ADTDZcvWeUxl2Xl/CZrWlEE+br6x0vo8sSNcoWRp4VF7ytG2DZEj3USN
         pFpiC9ymg3G5z9Jc2Y3+dlwlLsBUpXjiRbMkycL+KAAPpAdxXRrCpELTmDDK88fLn7
         v6Sik/98VUwlGfGQOSOzquinEtZM14VHsYxIOyDpdcqH723upwTXSqo3Z8OgTMgAVd
         wnLTx6N676zZQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v6 4/8] ext4: Reuse generic_ci_match for ci comparisons
Organization: Collabora
References: <20220519014044.508099-1-krisman@collabora.com>
        <20220519014044.508099-5-krisman@collabora.com>
        <YoW8yx9Fw9Rwiaja@sol.localdomain>
Date:   Thu, 19 May 2022 15:52:10 -0400
In-Reply-To: <YoW8yx9Fw9Rwiaja@sol.localdomain> (Eric Biggers's message of
        "Wed, 18 May 2022 20:43:07 -0700")
Message-ID: <87h75lnvv9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, May 18, 2022 at 09:40:40PM -0400, Gabriel Krisman Bertazi wrote:
>> Instead of reimplementing ext4_match_ci, use the new libfs helper.
>> 
>> It should be fine to drop the fname->cf_name in the encrypted directory
>> case for the hash verification optimization because the only two ways
>> for fname->cf_name to be NULL on a case-insensitive lookup is
>> 
>>  (1) if name under lookup has an invalid encoding and the FS is not in
>>  strict mode; or
>> 
>>  (2) if the directory is encrypted and we don't have the
>>  key.
>> 
>> For case (1), it doesn't matter, because the lookup hash will be
>> generated with fname->usr_name, the same as the disk (fallback to
>> invalid encoding behavior on !strict mode).  Case (2) is caught by the
>> previous check (!IS_ENCRYPTED(parent) ||
>> fscrypt_has_encryption_key(parent)), so we never reach this code.
>
> The code actually can be reached in case (2), because the key could have been
> added between ext4_fname_setup_ci_filename() and ext4_match().

Hm, I see! I didn't understand it would be possible to add a key during
a lookup from your previous explanation, thanks for clarifying.

> I *think* your change doesn't make it any worse, since in such a case the name
> comparison is going to be comparing a no-key name to a regular one, which will
> very likely fail.  So adding an additional way for the match to fail
> seems fine.

Either way, no point in setting it for failure.  I will restore the
fname->cf_name != NULL check.

> It's hard to reason about, though.  f2fs does things in a much cleaner way, as
> I've mentioned before, since it decides which type of match it wants at the
> beginning, when initializing struct f2fs_filename.

Yes, this is quite confusing. Are these implementation documented
anywhere?

Thank you for the review!

-- 
Gabriel Krisman Bertazi

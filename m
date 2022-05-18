Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB652C67A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiERWoM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiERWoL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 18:44:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004AF17789E
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 15:44:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B71A21F4146F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652913844;
        bh=L6dcGbgKc06/HeCG0OXaln8NHyKNVJM5rCJPx8KRzX8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KNT1FFohHdRtRTp+AxVrNQY54YG1ZzolgQE6Cm876E340Uw367n3y1zt/8elfGMba
         Jbz6glAnCadF6mVtkUTQio5RKipW3OHJxXmDT1VGWoIPaet0Qh9/9LLUFAA+rD8rFF
         400MFbuFGgfOTJNPMnFT4B+nXKhOI04zgQWSaWrQ0Z4ckbTqCt7zSlcAqASfaPbIdX
         AfYY/V/mD7I/IIUrn4EnyTtD3GcN9sAEeRs7AP3wtrklA6xP6TKpLs2KmufjALS5jb
         BLwboAsGAqXY8zfOuRabbAp++/POZo0EcvlHuq5m/9TwMW1ESoaPPuHCbkqyUOCEic
         FewEtzRBjPJIQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v5 4/8] ext4: Reuse generic_ci_match for ci comparisons
Organization: Collabora
References: <20220518172320.333617-1-krisman@collabora.com>
        <20220518172320.333617-5-krisman@collabora.com>
        <YoVHDdMYx5Lbn7aP@sol.localdomain>
Date:   Wed, 18 May 2022 18:44:00 -0400
In-Reply-To: <YoVHDdMYx5Lbn7aP@sol.localdomain> (Eric Biggers's message of
        "Wed, 18 May 2022 12:20:45 -0700")
Message-ID: <87pmkawjf3.fsf@collabora.com>
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

> On Wed, May 18, 2022 at 01:23:16PM -0400, Gabriel Krisman Bertazi wrote:
>> Instead of reimplementing ext4_match_ci, use the new libfs helper.
>> 
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
> [...]
>>  int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>>  				  struct ext4_filename *name)
>>  {
>> @@ -1432,20 +1380,25 @@ static bool ext4_match(struct inode *parent,
>>  #if IS_ENABLED(CONFIG_UNICODE)
>>  	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
>>  	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
>> -		if (fname->cf_name.name) {
>> -			if (IS_ENCRYPTED(parent)) {
>> -				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
>> -					fname->hinfo.minor_hash !=
>> -						EXT4_DIRENT_MINOR_HASH(de)) {
>> +		int ret;
>>  
>> -					return false;
>> -				}
>> -			}
>> -			return !ext4_ci_compare(parent, &fname->cf_name,
>> -						de->name, de->name_len, true);
>> +		if (IS_ENCRYPTED(parent) &&
>> +		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
>> +		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
>> +			return false;
>> +
>> +		ret = generic_ci_match(parent, fname->usr_fname,
>> +				       &fname->cf_name, de->name,
>> +				       de->name_len);
>> +		if (ret < 0) {
>> +			/*
>> +			 * Treat comparison errors as not a match.  The
>> +			 * only case where it happens is on a disk
>> +			 * corruption or ENOMEM.
>> +			 */
>> +			return false;
>>  		}
>> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
>> -						de->name_len, false);
>> +		return ret;
>>  	}
>
> This needs an explanation for why it's okay to remove
> 'fname->cf_name.name != NULL' from the condition for doing the hash comparison
> for an encrypted+casefolded directory entry.

Hi Eric,

The reason is that the only two ways for fname->cf_name to be NULL on a
case-insensitive lookup is 1) if name under lookup has an invalid
encoding and the FS is not in strict mode; or 2) if the directory is
encrypted and we don't have the key.  For case 1, it doesn't
matter, because the lookup hash will be generated with fname->usr_name,
the same as the disk (fallback to invalid encoding behavior on !strict
mode).  Case 2 is caught by the previous check
(!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent)), so we
never reach this code.

I'll add the above rationale to the commit message.

-- 
Gabriel Krisman Bertazi

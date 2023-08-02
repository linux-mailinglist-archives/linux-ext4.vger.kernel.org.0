Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BA76C81F
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 10:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHBINe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 04:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHBIND (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 04:13:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E2A1706;
        Wed,  2 Aug 2023 01:13:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362A21F8A4;
        Wed,  2 Aug 2023 08:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690963979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7M+3e0OSEJLBFDofj56MpmhOC0wRZC0hpJ4pH7leM0=;
        b=nX+85sEL+C/m2HU/aAlfq68WJEyu5rEUMazBhuSXWOJN+toZp/G2JO60Il7gDjEoRQxrT0
        YARfHDgQS25dFR1xxabcqMDMy/p7ZbbOeJf7nBMPClj+uID4txI2/pLhC+mv0oTx0m6nmb
        ragB2smhsPTtXjvB2P+I+H9YIcA3xCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690963979;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F7M+3e0OSEJLBFDofj56MpmhOC0wRZC0hpJ4pH7leM0=;
        b=VAWYsyRB9bep/yS7n5lv342kPVMXmMBRXF9DBXX/p+KMAwz6X7njuwIqGZPla6VQe1vKIW
        h1RU17eRs7eOOcBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8C3613919;
        Wed,  2 Aug 2023 08:12:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+qyLQoQymTJOQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 02 Aug 2023 08:12:58 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id ffb87824;
        Wed, 2 Aug 2023 08:12:57 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fname_setup_filename()
 error path
In-Reply-To: <20230802042305.GB1543@sol.localdomain> (Eric Biggers's message
        of "Tue, 1 Aug 2023 21:23:05 -0700")
References: <20230801144136.23565-1-lhenriques@suse.de>
        <20230802042305.GB1543@sol.localdomain>
Date:   Wed, 02 Aug 2023 09:12:57 +0100
Message-ID: <87wmydrhfa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Tue, Aug 01, 2023 at 03:41:36PM +0100, Lu=C3=ADs Henriques wrote:
>> If casefolding the filename fails, we'll be leaking fscrypt_buf name.
>> Make sure we free it in the error path.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ext4/crypto.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
>> index e20ac0654b3f..9e4503b051c4 100644
>> --- a/fs/ext4/crypto.c
>> +++ b/fs/ext4/crypto.c
>> @@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const=
 struct qstr *iname,
>>=20=20
>>  #if IS_ENABLED(CONFIG_UNICODE)
>>  	err =3D ext4_fname_setup_ci_filename(dir, iname, fname);
>> +	if (err)
>> +		fscrypt_free_filename(&name);
>>  #endif
>>  	return err;
>>  }
>
> Doesn't ext4_fname_prepare_lookup() have the same bug?

Doh! I looked into that function too and then completely forgot about it.
It may also call fscrypt_setup_filename(), so it has to do the free in the
error path as well.  I'll send out v2 to include that fix too.

> Also, please include a Fixes tag.

Ok, makes sense.  Thanks!

Cheers,
--=20
Lu=C3=ADs

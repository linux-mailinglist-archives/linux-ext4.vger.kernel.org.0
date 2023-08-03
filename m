Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAF76E3CA
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 10:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjHCI6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjHCI6T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 04:58:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6526EE58;
        Thu,  3 Aug 2023 01:58:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2371B219AE;
        Thu,  3 Aug 2023 08:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691053097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3n1Xwcb4VZeSgb4cQeQ3gMUuZkzy82ywXtFnmXwXFLo=;
        b=UTFScJUNTHA/ifu6d7I8Bq1rCz1+plajC7GH+WD/DO1z/vFGnMb4O85CvXzOf7iUBQoBdm
        iaNG0J0ovupOZmkh9NlWiM7Lx9LwvbXVmxqXiBB1a/Izdau4Aoo7JFn5upnHve5PTIFaX2
        qFpQK9XeHkJcPhkSabvlgNgbLjIiv84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691053097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3n1Xwcb4VZeSgb4cQeQ3gMUuZkzy82ywXtFnmXwXFLo=;
        b=OIvL1Hzv0YURFLHqO/DkC7i9CiIrVmFyWvH098+HiozNcz5F0fViL/PnMvxmJAuJgHHqPy
        sVNUo8sQ9LNvdIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3E50134B0;
        Thu,  3 Aug 2023 08:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DF/gKChsy2TFYwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Thu, 03 Aug 2023 08:58:16 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 66f404ce;
        Thu, 3 Aug 2023 08:58:15 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Daniel Rosenberg <drosen@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix memory leaks in
 ext4_fname_{setup_filename,prepare_lookup}
In-Reply-To: <20230803041918.GA1218@sol.localdomain> (Eric Biggers's message
        of "Wed, 2 Aug 2023 21:19:18 -0700")
References: <20230802094931.18215-1-lhenriques@suse.de>
        <20230803041918.GA1218@sol.localdomain>
Date:   Thu, 03 Aug 2023 09:58:15 +0100
Message-ID: <87sf90v6xk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Aug 02, 2023 at 10:49:31AM +0100, Lu=C3=ADs Henriques wrote:
>> If casefolding the filename fails, we'll be leaking fscrypt_buf name.
>
> fscrypt_buf =3D> fscrypt_name
>
>> diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
>> index e20ac0654b3f..3c05c7f3415b 100644
>> --- a/fs/ext4/crypto.c
>> +++ b/fs/ext4/crypto.c
>> @@ -33,6 +33,8 @@ int ext4_fname_setup_filename(struct inode *dir, const=
 struct qstr *iname,
>>	struct fscrypt_name name;
>>	int err;
>>
>>	err =3D fscrypt_setup_filename(dir, iname, lookup, &name);
>>	if (err)
>>		return err;
>>
>>	ext4_fname_from_fscrypt_name(fname, &name);
>>
>>  #if IS_ENABLED(CONFIG_UNICODE)
>>  	err =3D ext4_fname_setup_ci_filename(dir, iname, fname);
>> +	if (err)
>> +		fscrypt_free_filename(&name);
>>  #endif
>>  	return err;
>>  }
>> @@ -51,6 +53,8 @@ int ext4_fname_prepare_lookup(struct inode *dir, struc=
t dentry *dentry,
>>	struct fscrypt_name name;
>>	int err;
>>
>>	err =3D fscrypt_prepare_lookup(dir, dentry, &name);
>>	if (err)
>>		return err;
>>
>>	ext4_fname_from_fscrypt_name(fname, &name);
>>
>>  #if IS_ENABLED(CONFIG_UNICODE)
>>  	err =3D ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
>> +	if (err)
>> +		fscrypt_free_filename(&name);
>>  #endif
>>  	return err;
>>  }
>
> This works, but it's a bit weird that the freeing happens on the original=
 struct
> fscrypt_name after it has already been "moved" to the struct ext4_filenam=
e by
> ext4_fname_from_fscrypt_name().  That leaves a dangling pointer in the st=
ruct
> ext4_filename.  Maybe you should call ext4_fname_free_filename() instead,=
 even
> though it would do some unnecessary work?

That makes sense, specially because fname is a parameter and it's probably
a good idea to clean-up everything before returning an error.  Thanks.

Cheers,
--=20
Lu=C3=ADs

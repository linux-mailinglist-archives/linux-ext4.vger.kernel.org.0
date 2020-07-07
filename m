Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439F21686E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGGIgS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jul 2020 04:36:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgGGIgR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jul 2020 04:36:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so44206327wrs.11
        for <linux-ext4@vger.kernel.org>; Tue, 07 Jul 2020 01:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=PRfjhndMpcYdSuz0ANOR8GZWFcjRdgYjroD+Y+N13VY=;
        b=EXqIGtCOY3bCh+JG7/AHVar40Op3EAvrpH4BTX2S31NkvStn4AN55dfeiHaXNfzmBy
         gSmGWb5c7S6I6fnPv742FmztzUFA+rEUn9og5s2y4RfVH05KbDGIoJ1wquNvN4fx3b2N
         A9aLW9c/3IzPzn4nyG2T0dXUNr7xtBDvF9HghwYvINdnEern4FcjyaW8jhAGDH3hVGtG
         EgG6JeAoVhBNGS282ltRb9FT6eVDjwwdjsRf44rWeuJdaq4Y02fLMcEJVVsGtd8lwlJb
         ZyvsqQidUz8/0rE2xfNW4Ku3D+ewoup6t6rKnhJBhGjxlsfeHz0/k29NVx+waRanP3YY
         d7tA==
X-Gm-Message-State: AOAM532TYyx3ATPfXD0qqxizoFxCrAcQsNMfPxHFonHtThrtVpjA6O/N
        eUyy3X+FmyI8syLsI0UKHPEY8qK7orQ=
X-Google-Smtp-Source: ABdhPJxY0ZpkPaZZ+nKIM8ksS5Yi1TaikrrsXufS5woj6NUdXVvsORHbfxtL4F79yonjYJai/KWfVw==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr50432692wrh.186.1594110974186;
        Tue, 07 Jul 2020 01:36:14 -0700 (PDT)
Received: from neo-pc.sch (55d4bc09.access.ecotel.net. [85.212.188.9])
        by smtp.gmail.com with ESMTPSA id l8sm12311wrq.15.2020.07.07.01.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:36:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] e4crypt: if salt is explicitly provided to add_key,
 then use it
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
References: <20200706194727.12979-1-flo@geekplace.eu>
 <20200706215719.GA827691@gmail.com>
From:   Florian Schmaus <flo@geekplace.eu>
Autocrypt: addr=flo@geekplace.eu; prefer-encrypt=mutual; keydata=
 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
 Y3Hdt7I=
Message-ID: <16765dd5-3686-6083-7f9b-261b51953d32@geekplace.eu>
Date:   Tue, 7 Jul 2020 10:36:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706215719.GA827691@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="J2ZjxmFYPkxDazevumYnJrrPS60UTpmLy"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J2ZjxmFYPkxDazevumYnJrrPS60UTpmLy
Content-Type: multipart/mixed; boundary="MEHqJydP6UwNFzWgCAinCv7Z8Or9jxPc0"

--MEHqJydP6UwNFzWgCAinCv7Z8Or9jxPc0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/6/20 11:57 PM, Eric Biggers wrote:
> On Mon, Jul 06, 2020 at 09:47:25PM +0200, Florian Schmaus wrote:
>> Providing -S and a path to 'add_key' previously exhibit an unintuitive=

>> behavior: instead of using the salt explicitly provided by the user,
>> e4crypt would use the salt obtained via EXT4_IOC_GET_ENCRYPTION_PWSALT=

>> on the path. This was because set_policy() was still called with NULL
>> as salt.
>>
>> With this change we now remember the explicitly provided salt (if any)=

>> and use it as argument for set_policy().
>>
>> Eventually
>>
>> e4crypt add_key -S s:my-spicy-salt /foo
>>
>> will now actually use 'my-spicy-salt' and not something else as salt
>> for the policy set on /foo.
>>
>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>=20
> Thanks for these patches for e4crypt.

Thanks for your feedback.


> Note that e4crypt is in maintenance mode, and it hasn't been updated to=
 follow
> recommended security practices (e.g. using Argon2), to support the new
> encryption API which fixes a lot of problems with the original one, or =
to
> support the other filesystems that share the same encryption API.
>=20
> Instead you should use the 'fscrypt' tool: https://github.com/google/fs=
crypt
>=20
> What is your use case for still using e4crypt?

This sounds like 'fsscrypt' is an alternative to e4crypt. If so, then I
guess I have no use case for e4crypt, but simply use it because it is
available. Sadly there is no fscrypt package for my distribution
(Gentoo) available. Guess I have to look into that. :)

Besides that, my use case is to have a e4crytped directory accessible
after PAM authentication. For that I recently looked into pam_e4crypt
[1]. In fact, pam_e4crypt's README mentions fscrypt. But the small size
of pam_e4crypt made it look more appealing to me than fscrypt.


> And why do you want to explicitly specify a salt?

For some reason pam_e4crypt removed support for the
EXT4_IOC_GET_ENCRYPTION_PWSALT ioctl and only supports a file as source
for the salt. It took me a while to figure out that

e4crypt add_key -S s:my-spicy-salt /foo

would not use 'my-spicy-salt' for /foo. This is an attempt to fix that.


>> ---
>>  misc/e4crypt.8.in | 4 +++-
>>  misc/e4crypt.c    | 8 +++++++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/misc/e4crypt.8.in b/misc/e4crypt.8.in
>> index 75b968a0..32fbd444 100644
>> --- a/misc/e4crypt.8.in
>> +++ b/misc/e4crypt.8.in
>> @@ -48,7 +48,9 @@ values are 4, 8, 16, and 32.
>>  If one or more directory paths are specified, e4crypt will try to
>>  set the policy of those directories to use the key just added by the
>>  .B add_key
>> -command.
>> +command.  If a salt was explicitly specified, then it will be used
>> +by the policy of those directories.  Otherwise a directory-specific
>> +default salt will be used.
>=20
> This description isn't quite correct.  The salt is a value used to deri=
ve the
> encryption key; it's not part of the encryption policy itself.

Noted.


>>  .TP
>>  .B e4crypt get_policy \fIpath\fR ...
>>  Print the policy for the directories specified on the command line.
>> diff --git a/misc/e4crypt.c b/misc/e4crypt.c
>> index 2ae6254a..c82c6f8f 100644
>> --- a/misc/e4crypt.c
>> +++ b/misc/e4crypt.c
>> @@ -652,6 +652,7 @@ static void do_help(int argc, char **argv, const s=
truct cmd_desc *cmd);
>>  static void do_add_key(int argc, char **argv, const struct cmd_desc *=
cmd)
>>  {
>>  	struct salt *salt;
>> +	struct salt *explicit_salt =3D NULL;
>>  	char *keyring =3D NULL;
>>  	int i, opt, pad =3D 4;
>>  	unsigned j;
>> @@ -666,8 +667,13 @@ static void do_add_key(int argc, char **argv, con=
st struct cmd_desc *cmd)
>>  			pad =3D atoi(optarg);
>>  			break;
>>  		case 'S':
>> +			if (explicit_salt) {
>> +				fputs("May only provide -S once\n", stderr);
>> +				exit(1);
>> +			}
>>  			/* Salt value for passphrase. */
>>  			parse_salt(optarg, 0);
>> +			explicit_salt =3D salt_list;
>>  			break;
>>  		case 'v':
>>  			options |=3D OPT_VERBOSE;
>> @@ -703,7 +709,7 @@ static void do_add_key(int argc, char **argv, cons=
t struct cmd_desc *cmd)
>>  		insert_key_into_keyring(keyring, salt);
>>  	}
>>  	if (optind !=3D argc)
>> -		set_policy(NULL, pad, argc, argv, optind);
>> +		set_policy(explicit_salt, pad, argc, argv, optind);
>=20
> This causes a use-after-free because the memory pointed to by 'explicit=
_salt'
> can be reallocated by add_salt(), called from parse_salt():
>=20
>         for (i =3D optind; i < argc; i++)
>                 parse_salt(argv[i], PARSE_FLAGS_FORCE_FN);
>=20
> I think we shouldn't add these extra salts when a salt was explicitly s=
pecified.

I actually considered this, but then decided to go for smallest possible
change. The next iteration of the patch skips this if a salt was
explicitly specified.


> Moreover it appears the above code should just be removed, since
> get_default_salts() already handles adding salts for all ext4 filesyste=
ms.

I think only for the ones declared in /etc/mtab? Hence for filesystems
that are not in mtab it appears sensible to keep the code.

- Florian


1: https://github.com/neithernut/pam_e4crypt


--MEHqJydP6UwNFzWgCAinCv7Z8Or9jxPc0--

--J2ZjxmFYPkxDazevumYnJrrPS60UTpmLy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEl3UFnzoh3OFr5PuuIjmn6PWFIFIFAl8EM/xfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDk3
NzUwNTlGM0EyMURDRTE2QkU0RkJBRTIyMzlBN0U4RjU4NTIwNTIACgkQIjmn6PWF
IFLgLwf/ZEr+Jlh1+0x9df4ucQq1yTFVHAIP0ICWn/SSmWaT4VsGoRVkrenKT9bq
oK6CGfPI54wCKz07xZPiAYslQl27Ry2oVivqdmH1eweRp/W5BPxhqnLG95vGin8I
Rkw1nyqdL4S8+FOu68eE/+p8RnazBnk1ovCv244b5ArWK4vD+EgaHAx/uvY5+Pqs
LsMBlW1o8f0KvoSj8yr7Q6Zt6PkKGyi8KxthTxUaTYLmr0+XMtLRZRf9+VUGATwg
z5Y2hgESLQSqTzTFZMeCL6hpTXs0HtztcSJAGphcfejB8BSqEeU0lFEv7Onjj5sI
Xfe/SBKQ4Aam2N5PIhDQMTuHj0i+QA==
=i3yV
-----END PGP SIGNATURE-----

--J2ZjxmFYPkxDazevumYnJrrPS60UTpmLy--

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2FA34D7C2
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 21:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhC2TG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 15:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC2TGA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 15:06:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19D8C061574
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 12:06:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v10so9994891pgs.12
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RorQ748q47J9cIcc3KDZqcr8KRg50chRYdJMCGMgT4k=;
        b=oCyvwvtNjsYdKBP/rN3VCFwsQx7D8ZraUud/DE8bn2FTTvLL+ki23Nefz3jLa3TZg6
         4c3TCBOEvFEFZclbgFmwx3hfwwPNiZT8tH59puNF3nTYrH1DTobRooNJ17tz897CqVwk
         ZsOyIckY584+SYOw4uJx5cz8tNAoqBRXa66R3VBlQk62M0BZHholwD9FVbJgQFk9AefK
         K963P8IlcSSn39gO57WnHzaZvEVTvh5EWAYu9UymYOFvyEljugbqk0VjhEkvhyhoHlB2
         1Ee6bgMT/3bI/Nx1ULUCd3I1YvL26PdAP0tkVm9Po1xel3d7OC65xQYVX5hMqPCjj+nx
         X5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RorQ748q47J9cIcc3KDZqcr8KRg50chRYdJMCGMgT4k=;
        b=By29lOfClA5KrdNWFGdejImx/zdCzCt+FOQi2yLtIcxT8lbLyjEqujpUtUROY/eMCj
         PvCH8+k8e7ltzI58J0QIAXLN7VhIeW7RpgIa1P3nDZoCZK7/LEfNJ7RfgWOVp3x4rJ3s
         EYVk80iRteHbQ2k/yThu1UIvSwjuEsERFw1vAHg2AFLNYBTIsnJRMUR+YkktERTsjtPY
         Eu0tM3CzoML3SFkB0+SBUSmsF84Ta21noZ94l8U7Xo7hNIF0G8HX50veuurephUo8xlx
         TcP6V4DcKo3SZphoXNycX8bObDUdau2TLuUMpL8FjmmccHbIQy3VhUAGyx7RUBjDHl/F
         7JLw==
X-Gm-Message-State: AOAM531J8kV7HaC5ui3nl/Yt6St382ohmIzV6XYqD0xmr1aTDYFzUhM8
        w+HVIGirGudQXrH8jRseaGJ1ug==
X-Google-Smtp-Source: ABdhPJwLWOVii5iG9l/Ok3ab+uMD0IczUVR3+9f6cu65O/u0bs7GfBBNcAvxcLZXGcGsxSkdzpFDsg==
X-Received: by 2002:a65:4d49:: with SMTP id j9mr3983602pgt.113.1617044760211;
        Mon, 29 Mar 2021 12:06:00 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y194sm17562582pfb.21.2021.03.29.12.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:05:58 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E6C89307-296F-4E91-A850-801CC527B3DE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F8019E1C-9D5C-492A-9768-2F5E06CEBAED";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Date:   Mon, 29 Mar 2021 13:05:55 -0600
In-Reply-To: <YGH6+VzYVVvbNn7r@google.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <A08FAD7B-899F-4B40-9881-2ACD45399471@dilger.ca>
 <CAD+ocbxp5s5QfOKheftMMyd69RaZtS9z8RBnjUqZ3siOCdfFbg@mail.gmail.com>
 <20210327020823.GC22091@magnolia> <YGH6+VzYVVvbNn7r@google.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F8019E1C-9D5C-492A-9768-2F5E06CEBAED
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Mar 29, 2021, at 10:06 AM, Leah Rumancik <leah.rumancik@gmail.com> =
wrote:
>=20
> On Fri, Mar 26, 2021 at 07:08:23PM -0700, Darrick J. Wong wrote:
>> On Fri, Mar 26, 2021 at 06:43:52PM -0700, harshad shirwadkar wrote:
>>> On Fri, Mar 26, 2021 at 4:08 PM Andreas Dilger <adilger@dilger.ca> =
wrote:
>>>>=20
>>>> On Mar 25, 2021, at 12:12 PM, Leah Rumancik =
<leah.rumancik@gmail.com> wrote:
>>>>>=20
>>>>> Zero out filename field when file is deleted. Also, add mount =
option
>>>>> nowipe_filename to disable this filename wipeout if desired.
>>>>=20
>>>> I would personally be against "wipe out entries on delete" as the =
default
>>>> behavior.  I think most users would prefer that their data is =
maximally
>>>> recoverable, rather than the minimal security benefit of erasing =
deleted
>>>> content by default.
>>> I understand that persistence of filenames provides recoverability
>>> that users might like but I feel like that may break sooner or =
later.
>>> For example, if we get directory shrinking patches[1] merged in or =
if
>>> we redesign the directory htree using generic btrees (which will
>>> hopefully support shrinking), this kind of recovery will become very
>>> hard.
>>>=20
>>> Also, I was wondering if persistence of file names was by design? or
>>> it was there due to the way we implemented directories?
>>=20
>> I bet it wasn't done by design -- afaict all the recovery tools are
>> totally opportunistic in that /if/ they find something that looks =
like a
>> directory entry, /then/ it will pick that up.  The names will =
eventually
>> get overwritten, so that's the best they can do.
>>=20
>> (I would also wager that people don't like opt-out for new behaviors
>> unless you're adding it as part of a new feature...)
>>=20
>> --D
>=20
> What about a mount option to enable the filename wipe (with the wiping
> disabled by default)?

I would be OK with a mount option to enable it globally, or =
EXT2_SECRM_FL
to trigger this on a per-file or per-directory basis (entry is zeroed
if this is set on either the file or the directory it is located in, and
possibly the file's data blocks are trimmed from flash).

Cheers, Andreas

>>> [1] =
https://patchwork.ozlabs.org/project/linux-ext4/list/?series=3D166560
>>>=20
>>> Thanks,
>>> Harshad
>>>>=20
>>>> I think that Darrick made a good point that using the EXT4_SECRM_FL =
on
>>>> the inode gives users a good option to enable/disable this on a per
>>>> file or directory basis.
>>>>=20
>>>>> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
>>>>> ---
>>>>> fs/ext4/ext4.h  |  1 +
>>>>> fs/ext4/namei.c |  4 ++++
>>>>> fs/ext4/super.c | 11 ++++++++++-
>>>>> 3 files changed, 15 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>> index 826a56e3bbd2..8011418176bc 100644
>>>>> --- a/fs/ext4/ext4.h
>>>>> +++ b/fs/ext4/ext4.h
>>>>> @@ -1247,6 +1247,7 @@ struct ext4_inode_info {
>>>>> #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT       0x00000010 /* =
Journal fast commit */
>>>>> #define EXT4_MOUNT2_DAX_NEVER         0x00000020 /* Do not allow =
Direct Access */
>>>>> #define EXT4_MOUNT2_DAX_INODE         0x00000040 /* For printing =
options only */
>>>>> +#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe =
filename on del entry */
>>>>>=20
>>>>>=20
>>>>> #define clear_opt(sb, opt)            EXT4_SB(sb)->s_mount_opt &=3D =
\
>>>>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>>>>> index 883e2a7cd4ab..ae6ecabd4d97 100644
>>>>> --- a/fs/ext4/namei.c
>>>>> +++ b/fs/ext4/namei.c
>>>>> @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode =
*dir,
>>>>>                      else
>>>>>                              de->inode =3D 0;
>>>>>                      inode_inc_iversion(dir);
>>>>> +
>>>>> +                     if (test_opt2(dir->i_sb, WIPE_FILENAME))
>>>>> +                             memset(de_del->name, 0, =
de_del->name_len);
>>>>> +
>>>>>                      return 0;
>>>>>              }
>>>>>              i +=3D ext4_rec_len_from_disk(de->rec_len, =
blocksize);
>>>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>>>> index b9693680463a..5e8737b3f171 100644
>>>>> --- a/fs/ext4/super.c
>>>>> +++ b/fs/ext4/super.c
>>>>> @@ -1688,7 +1688,7 @@ enum {
>>>>>      Opt_dioread_nolock, Opt_dioread_lock,
>>>>>      Opt_discard, Opt_nodiscard, Opt_init_itable, =
Opt_noinit_itable,
>>>>>      Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
>>>>> -     Opt_prefetch_block_bitmaps,
>>>>> +     Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
>>>>> #ifdef CONFIG_EXT4_DEBUG
>>>>>      Opt_fc_debug_max_replay, Opt_fc_debug_force
>>>>> #endif
>>>>> @@ -1787,6 +1787,7 @@ static const match_table_t tokens =3D {
>>>>>      {Opt_test_dummy_encryption, "test_dummy_encryption"},
>>>>>      {Opt_inlinecrypt, "inlinecrypt"},
>>>>>      {Opt_nombcache, "nombcache"},
>>>>> +     {Opt_nowipe_filename, "nowipe_filename"},
>>>>>      {Opt_nombcache, "no_mbcache"},  /* for backward compatibility =
*/
>>>>>      {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
>>>>>      {Opt_removed, "check=3Dnone"},    /* mount option from ext2/3 =
*/
>>>>> @@ -2007,6 +2008,8 @@ static const struct mount_opts {
>>>>>      {Opt_max_dir_size_kb, 0, MOPT_GTE0},
>>>>>      {Opt_test_dummy_encryption, 0, MOPT_STRING},
>>>>>      {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
>>>>> +     {Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR =
| MOPT_2 |
>>>>> +             MOPT_EXT4_ONLY},
>>>>>      {Opt_prefetch_block_bitmaps, =
EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
>>>>>       MOPT_SET},
>>>>> #ifdef CONFIG_EXT4_DEBUG
>>>>> @@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct =
seq_file *seq, struct super_block *sb,
>>>>>      } else if (test_opt2(sb, DAX_INODE)) {
>>>>>              SEQ_OPTS_PUTS("dax=3Dinode");
>>>>>      }
>>>>> +
>>>>> +     if (!test_opt2(sb, WIPE_FILENAME))
>>>>> +             SEQ_OPTS_PUTS("nowipe_filename");
>>>>> +
>>>>>      ext4_show_quota_options(seq, sb);
>>>>>      return 0;
>>>>> }
>>>>> @@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct =
super_block *sb, void *data, int silent)
>>>>>      if (def_mount_opts & EXT4_DEFM_DISCARD)
>>>>>              set_opt(sb, DISCARD);
>>>>>=20
>>>>> +     set_opt2(sb, WIPE_FILENAME);
>>>>> +
>>>>>      sbi->s_resuid =3D make_kuid(&init_user_ns, =
le16_to_cpu(es->s_def_resuid));
>>>>>      sbi->s_resgid =3D make_kgid(&init_user_ns, =
le16_to_cpu(es->s_def_resgid));
>>>>>      sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
>>>>> --
>>>>> 2.31.0.291.g576ba9dcdaf-goog
>>>>>=20
>>>>=20
>>>>=20
>>>> Cheers, Andreas


Cheers, Andreas






--Apple-Mail=_F8019E1C-9D5C-492A-9768-2F5E06CEBAED
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBiJRMACgkQcqXauRfM
H+CyJw/9FOXe/ZR02X5+cF1ylwkrcj7K/L7KlYEZcGrPGFdoOCh4rAp+D9KvCTp7
qFSv2zEWdcnElC1/lBPAMIYje1U+N2nCETLeFwKIOdO9BXLEd+4CNe1qt5uQJHI8
EnsDkHfXRQs3nVYNc8xWR0tiDQ1qtJB3+aJAUQOsA/Clufq/1/OBkgjO//IrwF1e
16AIeeh+g2OsbwTG5t6JQXwiAgFl4kSwlMcYphhyhhM4Kavf2V8IWY9c7OjZqJ9K
WRGertUDpnZmSGIULsoHUaucJyX4fcW7YpdJADABZatsp2q5zlAbKYhzajgb3b0x
LmEN/kvpsrgL7nOCZes8z9HZ3nrbjtdRqaIc7kersTgSfooiwI5eom3UQfj924io
0yZQ1St+Ywf8wPm/K0UXZT+1XfyVZK29HFpZSRFP0C0O0bdO4gQLk/1lpVK2+j2G
2Wwd2RSJwAnPBs+n7GBTzInR1BkGm9p7y0G5ReubiQg9pa5yJUtf0yge4KBR30vV
U4xSZ0956jMgnsDQ3dpwWwRi/TeWEZe8/5u2DolzwJaxMcsakDF1lAWEdLfQqro5
/ZYNA69/lNB4fGIJjLifTxcFXh24Tv7WoqpDCn/tb5S73S0soiI/ugV05jbKrUVG
fdA/IXsE1/dw+Q/C2o6h8QlHAO8JMji0Ar5wIJGgB31nORwXnBk=
=VJtN
-----END PGP SIGNATURE-----

--Apple-Mail=_F8019E1C-9D5C-492A-9768-2F5E06CEBAED--

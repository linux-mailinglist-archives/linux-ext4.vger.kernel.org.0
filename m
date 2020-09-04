Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D617625E21D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIDTn3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIDTn2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 15:43:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD6C061244
        for <linux-ext4@vger.kernel.org>; Fri,  4 Sep 2020 12:43:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so1618474plk.10
        for <linux-ext4@vger.kernel.org>; Fri, 04 Sep 2020 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XwCARallkj0rgJqDGCGqgiaLIoOaF3YZaTybmXwP3cg=;
        b=bxeJ3njkQcAj71kqb9TISkLsZsiPym7o0v06twQQVxFOt6FRFwxJL/E6IOvd8SBvmy
         e9d9SEQuqCEck2/FuHhxrRm/qUrcLLMHOPERALeQ18k9hpVinid6H5bLoQ8e4JeuvSFm
         qEbYTFBgxaVvwR92Y8HDOubV9dyi0K/EbTjPqpRC2g16qCxoS3yDkdpDgquVjDqLQ6d5
         y1FdXIoLLKQPKvL6L8qN7QAvHpzMgDJKqimLfgOe+Bt/oO9YgvtjBVxRpRNs4i4vYx7w
         DmHXRMQZ4lkfYVIGox4QOgflaDf80PtOQYJbRiXeuHR4TWTwyzoepEGZNMf9aSw7GCHp
         E5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XwCARallkj0rgJqDGCGqgiaLIoOaF3YZaTybmXwP3cg=;
        b=aY9s5j4sW6QbqjCn0FmY/x+gEiBqs0ICnOx35f2MUv7A6O1lvPDs48/jowRDggE/kv
         DRhkILKNZb4LMySh/8KilxYlrO9nFqkqOKXPW6bV4Pj9O/12hDMsl2BydNnjXDErcQP1
         or1YkQa7bR4eNVsLtmKQiHmac2zu/VP8EWn4ljm5iHv7I5bxV3JBf6YeMkEjiFDAeG1J
         EYdoFCTV8p2GZr+Mb2bBDmkvnpAr9bwy6JYW1gCiEa2yD1Rj6qEjouxLFsaWYw3Jdv9i
         epFkCzQ5WTWCzKZfCNhrUXRyuDfxMOAtOJGkmBbOFl3EnFctlfTTut7L1nFpJ1nXnTWp
         VT9w==
X-Gm-Message-State: AOAM531pVaaCNHu+NsaxrysYSmCl+Fdzz+DoYJPCTnnycovd4UEMFh7t
        6iyWUDxya3t2p0ZmHqpRO2Zu9A==
X-Google-Smtp-Source: ABdhPJwxzpHMx6ZtnATcqXjfzeVPcVhCAnIthreNV8ccUa8zgv67hPwW/Z1TM2Nr7gPuoOQsNMLB8A==
X-Received: by 2002:a17:90b:eca:: with SMTP id gz10mr9308999pjb.3.1599248607435;
        Fri, 04 Sep 2020 12:43:27 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d5sm7103608pfc.77.2020.09.04.12.43.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 12:43:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E65D3B4E-A8C4-4BC8-9A6C-07E900F90D9A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3860A408-B172-4493-8B3B-B87496C63187";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] create_inode: set xattrs to the root directory as well
Date:   Fri, 4 Sep 2020 13:43:18 -0600
In-Reply-To: <159920782384.787733.9857416604675445355@kwain>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
To:     Antoine Tenart <antoine.tenart@bootlin.com>
References: <20200717100846.497546-1-antoine.tenart@bootlin.com>
 <B2EE7AC5-BEC0-46A8-8C37-D3085645F94C@dilger.ca>
 <159609406998.3391.5621985067917886015@kwain>
 <159920782384.787733.9857416604675445355@kwain>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3860A408-B172-4493-8B3B-B87496C63187
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Sep 4, 2020, at 2:23 AM, Antoine Tenart <antoine.tenart@bootlin.com> =
wrote:
>=20
> Hello,
>=20
> Quoting Antoine Tenart (2020-07-30 09:27:50)
>>=20
>> Gentle ping. What's the status of this patch?
>=20
> Do anyone know if anything else is required to get this merged?

Based on other emails to the list, Ted has a backlog of patches to be
merged for ext4 and e2fsprogs, so it isn't that your patch was missed.
He will hopefully be able to start landing patches again soon.

Cheers, Andreas

>> Quoting Andreas Dilger (2020-07-17 13:17:08)
>>>=20
>>>> On Jul 17, 2020, at 4:08 AM, Antoine Tenart =
<antoine.tenart@bootlin.com> wrote:
>>>>=20
>>>> populate_fs do copy the xattrs for all files and directories, but =
the
>>>> root directory is skipped and as a result its extended attributes =
aren't
>>>> set. This is an issue when using mkfs to build a full system image =
that
>>>> can be used with SElinux in enforcing mode without making any =
runtime
>>>> fix at first boot.
>>>>=20
>>>> This patch adds logic to set the root directory's extended =
attributes.
>>>>=20
>>>> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
>>>=20
>>> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>>>=20
>>>> ---
>>>>=20
>>>> Since v1:
>>>> - Moved the set_inode_xattr logic for the root directory
>>>>   from __populate_fs to populate_fs2.
>>>>=20
>>>> misc/create_inode.c | 8 ++++++++
>>>> 1 file changed, 8 insertions(+)
>>>>=20
>>>> diff --git a/misc/create_inode.c b/misc/create_inode.c
>>>> index e8d1df6b55a5..fe66faf1b53d 100644
>>>> --- a/misc/create_inode.c
>>>> +++ b/misc/create_inode.c
>>>> @@ -1050,9 +1050,17 @@ errcode_t populate_fs2(ext2_filsys fs, =
ext2_ino_t parent_ino,
>>>>      file_info.path_max_len =3D 255;
>>>>      file_info.path =3D calloc(file_info.path_max_len, 1);
>>>>=20
>>>> +     retval =3D set_inode_xattr(fs, root, source_dir);
>>>> +     if (retval) {
>>>> +             com_err(__func__, retval,
>>>> +                     _("while copying xattrs on root directory"));
>>>> +             goto out;
>>>> +     }
>>>> +
>>>>      retval =3D __populate_fs(fs, parent_ino, source_dir, root, =
&hdlinks,
>>>>                             &file_info, fs_callbacks);
>>>>=20
>>>> +out:
>>>>      free(file_info.path);
>>>>      free(hdlinks.hdl);
>>>>      return retval;
>>>> --
>>>> 2.26.2
>>>>=20
>>>=20
>>>=20
>>> Cheers, Andreas
>>>=20
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>> --
>> Antoine T=C3=A9nart, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
>=20
> --
> Antoine T=C3=A9nart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


Cheers, Andreas






--Apple-Mail=_3860A408-B172-4493-8B3B-B87496C63187
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9SmNcACgkQcqXauRfM
H+B6Ag//aeRRAzRttGf5VVDhc0hTVFZXuwV+dTmTqdgxrfI6qFFEbcGHDQ1wXL++
EkR8DkkWPaQ/m+wnTxqN1iA2p0VZl1W2p9h5z6QDtPlx4sB6RKZXqWNT6kQAZDLo
Bmctq/sG5eMnVJ45BJMDmXbE61EeMIFsafjZzV3XiMq+YbaJUIEwqVbr6OdxNGa1
9/2TozQC9uT4E4OLO3qxWZ9ZfsFJgygDZyQ2fcDTNEdrkrKuzijuaspDux1PlZkc
fJjoWpM7yKCpUWCFcs6F7t8p0lbsfE5DDp0nYlZImr+obRh+AucCM27jOUOcCN3C
p/B23Y9FFNYxHR18SWpRzS611h8nXif+1V8STp2+t2ktrScfz/LMXYXXlk0aU7kf
TQM3RLd5Z7Yy2tEy/H4wrHbTXJ0HZwD8z59cQFWFs6UDJWgzjvlhTFCDswDdUG3Q
56nAKmS+aJlcaDsoudS8t+adfU1xZPH1vMXrCooZ6Z/qo5NAgU2qToR3DD/zNiaV
ybhecb2jRXZz30XNjCU/J12iUvk/BaKgHG4N8N/0+++pjIzYOP5BeK0BYyY9A1it
m8gX1Tk81niQbSXrRtbDhJiZYYpm90oNTV2HCU4wiAMhwEbLysjbO1UdxMjD5+G/
0Vt9dsPV0NatynaCxgE2glYJvVAAqjAVZs/J12tE7Y9nB/fWPMY=
=a6/n
-----END PGP SIGNATURE-----

--Apple-Mail=_3860A408-B172-4493-8B3B-B87496C63187--

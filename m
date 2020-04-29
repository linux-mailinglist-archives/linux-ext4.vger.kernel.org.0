Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C5E1BD2FA
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 05:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD2DeR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 23:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726551AbgD2DeQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 23:34:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B597C03C1AC
        for <linux-ext4@vger.kernel.org>; Tue, 28 Apr 2020 20:34:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so436207pfx.7
        for <linux-ext4@vger.kernel.org>; Tue, 28 Apr 2020 20:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=aIyYPW+iEnQ265kBjcNNhp/ZRHlYVKAjheGX37KyuWw=;
        b=RTLC1rPtjO5HFxAIEkdr2aL5CWJx+uj0TG7BXgCliqoOfot61lUJ2eLlaDtWMqPv37
         qb9wdb6OMRISjcVeCPguATO/zoYjqDPsO6QUsFHd2gm7ZjkKYak/WInvpoN6JmpVQ5Qc
         yXVaNdHTL18TYsemCudm6MUjmcXuuyZBAafCpGM5SqhHF6w9s8/n2I0MY/2bprUNVQlB
         qvdEvilJFN2YylavMsXLi08/bMXlVyVyd3T1MfURwUXbh7KTG3IZlruUqlckBLJTmUmC
         MWop/2mIzJjIoMFQMDySSJ7+OEND9xy2dSP2U+1rwBSub/A4JjG6gAFc/AkjLDx6xN2i
         cfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=aIyYPW+iEnQ265kBjcNNhp/ZRHlYVKAjheGX37KyuWw=;
        b=iQ9sTw1AlDRC3ro1buZVPtFZ6pO7Wm3s2P2wuD5MkYAW/gHmQZHQKDKe4CBNJUet8k
         NLA8CBvpHIwzKYkQsNnHuY0pIVmDY4udPKzh5lyvszgal4hvfozTkyTBGZo37RbvgWpo
         vL3N3B/QaWy7jcZVQZvrZTMWbmG+5tS19aKIQAZrKDsROFdgejPMR8QCYCvMDdC0gb/2
         D6l+Tu259cLDCyA/Uy0KBMu57IjEPrCh4VlVwNJTGeu+kH+O9SazGysgsNbPniUrg110
         kouEhFDk4thckxwoT+QcB+oflUf2Jt7sVhD/zPovidiXL9sUnZDqi2U5PamRojUSLJYH
         ep1g==
X-Gm-Message-State: AGi0PuZZdFEhsR5+ND/YbzFjOsItfMq9dF7jjhm+J3yJvroI2AHJN+6J
        VVIyBpdJ3VsY6dCjTQwGEzTuSw==
X-Google-Smtp-Source: APiQypJueIBzxMoy4LLxkSbFfWrQepqJF09kHuLeyNdqEw3CLmkdPFGk3o3zDGgYpg2GJbwShOMupw==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr31208824pff.95.1588131255557;
        Tue, 28 Apr 2020 20:34:15 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e135sm16522556pfh.37.2020.04.28.20.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:34:14 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3FF8B32A-0CB2-4818-95AA-5E76FE494EDB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_681417AA-B0C9-46DC-92C6-B0CCD0027FC4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 and project quotas bugs
Date:   Tue, 28 Apr 2020 21:34:09 -0600
In-Reply-To: <20200428153228.GB6426@quack2.suse.cz>
Cc:     Francois <rigault.francois@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_681417AA-B0C9-46DC-92C6-B0CCD0027FC4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 28, 2020, at 9:32 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Hello!
>=20
> On Tue 28-04-20 08:41:59, Francois wrote:
>> my goal is to make some kind of ansible playbook to install project
>> quotas, so I am interested in using a tool like setquota, I also want
>> the teams behind the capped directories, to think about a clean-up
>> mechanism (the quota would just be a temporary annoyance for them), =
so
>> it should not be "jailbreakable" too easily.
>=20
> Hum, that "not jailbreakable" part is going to be difficult unless you =
also
> confine those users also in their user namespace. Because any user is
> allowed to change project ID of the files he owns arbitrarily if he is
> running in the initial user namespace. Project quotas have been =
designed as
> an advisory feature back in Irix days... There are talks of allowing =
to
> tweak the behavior (i.e., to allow setting of project id only by =
sysadmin)
> by a mount option but so far nobody has implemented it.

We tried to implement this for ext4, but Dave Chinner argued that
allowing anyone (at least in the root namespace) to set the project
ID to anything they wanted was part of how project quotas are
_supposed_ to work.

We ended up adding a restriction at the Lustre level, defaulting to
only allow root (chprojid_gid=3D0, via CAP_SYS_RESOURCE), or admins in
a specific numeric group (with chprojid_gid=3DN), to change the projid,
and denying regular users the ability to change the projid of files.

This can be changed by setting "chprojid_gid=3D-1" to allow users in
any group to change the projid of files, returning the XFS behavior.
The "chprojid_gid" is essentially a sysfs tunable for Lustre, but it
could also/instead be a mount option for ext4, if that is preferred.
I don't have a particular attachment to the parameter name, or how
it is set by the admin, but I think something like this is needed.


>> 2- project quota are a bit too easy to escape:
>> dd if=3D/dev/zero of=3Dsomeoutput oflag=3Dappend
>> loop0: write failed, project block limit reached.
>> dd: writing to 'someoutput': Disk quota exceeded
>> 2467+0 records in
>> 2466+0 records out
>> 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
>> vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
>> vagrant@localhost:/mnt/loop/abc/mydir3> dd if=3D/dev/zero =
of=3Dsomeoutput
>> oflag=3Dappend
>> dd: writing to 'someoutput': No space left on device
>> 127393+0 records in
>> 127392+0 records out
>> 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s
>=20
> Yes and as I mentioned above this is deliberate.

That may be the historical XFS behavior, but IMHO, it doesn't make
this behavior *useful*.  If *anyone* can change the projid of files
that makes them mostly useless.  They might be OK for informational
or accounting purposes (e.g. fast "du" of a directory) in a friendly
user environment, but they are useless for any space management (i.e.
anyone can easily bypass project limits by "chattr -p $RANDOM <file>").

I'd prefer to make the project quotas useful out of the box for ext4,
by implementing the chprojid_gid tunable, or something equivalent.
If there are users/sites that want identical behavior to XFS, they
can always set chprojid_gid=3D-1 to allow anyone to change the projid.

I'd be happy to understand what Dave doesn't like about this proposal,
but the last time the enforcement of project quotas was discussed, my
attempt to figure this out ended with silence, see thread ending at:

=
https://lore.kernel.org/linux-ext4/6B0D1F84-0718-4E43-87D4-C8AFC94C0163@di=
lger.ca/

Maybe this time we can get over the hump?  Is it just some implicit
difference between "directory quota" and "project quota" that exists
in XFS that I (and everyone using ext4) does not understand?

Cheers, Andreas


PS: Implementing /etc/projid support for e2fsprogs chattr/lsattr to
allow project names would also be useful, but IMHO less important.
That would be a relatively easy feature for someone to implement,
since it only involves userspace and is unlikely to get objections.




--Apple-Mail=_681417AA-B0C9-46DC-92C6-B0CCD0027FC4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6o9bEACgkQcqXauRfM
H+BeUg//TNuWkKcy3i231uXUXRl+8aZiL1FxT0kRHc8oXmCVFTBfsQf0M2ogg4M8
6/aoDx1+6kX+jHAlNv0Bj50IKHtYM/2i+4kVPxuujtW9FGvlSV6qBAEJWcH3/4qJ
f/WVPGx9LI/ewMFbBuV1OaacZjwujO+hwPPUkHbWbW3C8Q5kotiVjrwzjT9Ulp2k
h4wmEyCrX6KamBKBpVaXCA2Wtz12I/cWhrBtVWghL5ZNUhEKiKkdtjM1C8VOkwzu
XHRhbDxqV/8TjvVrh66kNLNvwH2DYPFB8r8Ehc666JgVDH9gkmoGKuMSCnZyZrME
vucurwXmNXhva9LjU0FUlJeEXaBY/zAfnctvtrOBHi9gqjLMyPm3k28tFTNgpxUj
/FgGwMLO01HaWNnuvkTftzNfv/5Zxh0x9nLJGet62J7cM4qgFJOdpJCjH7WWp235
e83o+OJjvwEYJQwgYwDDzyOqpt0owXJp9GuF77FGOsXcBOMZ4A3uej4K+J8yGp1g
l1sKlS2T+IWfNlTMou+/JHUuDmqdydyQtGWHU9gcpzmuAjFlxN2hoRc0hNI9LqLw
/1IWBXHq6qQYIypG4iXtSPrUqEjT5Z3MtKVtS0qUYDidghDyUQW5xIszY3aNKJ6x
VYPKqowMD2Qg4bE4TwyavqLQH555e12OjWeyugY/18OabtVnSgQ=
=jfgi
-----END PGP SIGNATURE-----

--Apple-Mail=_681417AA-B0C9-46DC-92C6-B0CCD0027FC4--

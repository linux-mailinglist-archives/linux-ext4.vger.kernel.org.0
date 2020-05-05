Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110F91C610B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 21:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEETbd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 May 2020 15:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEETbc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 May 2020 15:31:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE35C061A0F
        for <linux-ext4@vger.kernel.org>; Tue,  5 May 2020 12:31:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j21so1463878pgb.7
        for <linux-ext4@vger.kernel.org>; Tue, 05 May 2020 12:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5KdaGpmZlQc2P7Rd/J0kuNef9HUzJlJm/AbFxKhXnfU=;
        b=Yg9wsQ9FwedbWvJgV+hyGzIoYmLIIeOLdIER0QEbGzzd6AyMnNtruHLm5bemBq6EKc
         /DLerT7zxhZO0n1N1YbJguOiA95idifBomxvd8LqJXqlouj+B4kElAVdZxFNorbTAkcU
         nObdTVVyMj8XGiRBIWoeEyt7k3p3PDVg7Gi7G5rhbcV1lTHQENbOUdrEy1WVfmjKFy5g
         ldAMJfeNfR3CesdQwXRB078NI/5LbF79AJJhxTGbSJV+2DFss7RqTzUinV4uYdFD+FHm
         vORtWyzNPECXiLtM+1jubHYeyGDSVFFVRg9A2OnxLXu/yWUfE4AMLH0UVoG0tHlw77ev
         gugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5KdaGpmZlQc2P7Rd/J0kuNef9HUzJlJm/AbFxKhXnfU=;
        b=pnES9KLCPPZ8+CyN7oW539dHvFA/SGmvUy+GZXm4tKIQmINu+eQbmp+KY5sZBTTcoi
         /DFx62+OpweFBst6DffO37xwpwVDN05qW0poyTx3+Uw/0qbTLhLGX3doig1pbKHztrFi
         HUXMn7oaX4lzZyc9w7KFhwiUL++Ry/uTcR8Ysh+QxQElsJumFsL7QCXc0e5sdpH1fwrt
         DXh+iGpfAe6HUADrTR99Ppt2/JS7i/Pu7gJqEo+tnCVa+aF5/uS13yG56O1D0Mo5wE/B
         t9TpRpM6VBJwuarON0meNti4ABg5yV7tcx6NPCC3PK3nj9E3asQeOUNj3kJ676/t7and
         QSnw==
X-Gm-Message-State: AGi0PubdrE7hOHvn6YM8zL0GbkhVduruH6o7J8XnCaLiwTWqI0OhZjsu
        V7OT5vDr3WKQPFVfA0Sh889JwQ==
X-Google-Smtp-Source: APiQypLc+r5IATRlPVMvwT/jeC0ojr1GqI2ZG6//RgF+dciCnxVufv99Zl0nqQw58EQyvEl82g7eFA==
X-Received: by 2002:a63:bd42:: with SMTP id d2mr4019676pgp.214.1588707091780;
        Tue, 05 May 2020 12:31:31 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q21sm2651248pfg.131.2020.05.05.12.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 12:31:30 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EE2548BC-1A7B-4C9B-BE48-B6412F5BB012@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6BF613E4-61FE-452C-B1D6-60BBB8E5E8C0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 and project quotas bugs
Date:   Tue, 5 May 2020 13:31:28 -0600
In-Reply-To: <20200505003222.GF2005@dread.disaster.area>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, Francois <rigault.francois@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Dave Chinner <david@fromorbit.com>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
 <3FF8B32A-0CB2-4818-95AA-5E76FE494EDB@dilger.ca>
 <20200429150132.GJ6733@magnolia> <20200505003222.GF2005@dread.disaster.area>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6BF613E4-61FE-452C-B1D6-60BBB8E5E8C0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 4, 2020, at 6:32 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Wed, Apr 29, 2020 at 08:01:32AM -0700, Darrick J. Wong wrote:
>> On Tue, Apr 28, 2020 at 09:34:09PM -0600, Andreas Dilger wrote:
>>>=20
>>> We tried to implement (restricted project IDs) for ext4, but
>>> Dave Chinner argued that allowing anyone (at least in the root
>>> namespace) to set the project ID to anything they wanted was
>>> part of how project quotas are _supposed_ to work.
>>>=20
>>> We ended up adding a restriction at the Lustre level, defaulting to
>>> only allow root (chprojid_gid=3D0, via CAP_SYS_RESOURCE), or admins =
in
>>> a specific numeric group (with chprojid_gid=3DN), to change the =
projid,
>>> and denying regular users the ability to change the projid of files.
>>>=20
>>> This can be changed by setting "chprojid_gid=3D-1" to allow users in
>>> any group to change the projid of files, returning the XFS behavior.
>>> The "chprojid_gid" is essentially a sysfs tunable for Lustre, but it
>>> could also/instead be a mount option for ext4, if that is preferred.
>>> I don't have a particular attachment to the parameter name, or how
>>> it is set by the admin, but I think something like this is needed.
>>>=20
>>>=20
>>>>> 2- project quota are a bit too easy to escape:
>>>>> dd if=3D/dev/zero of=3Dsomeoutput oflag=3Dappend
>>>>> loop0: write failed, project block limit reached.
>>>>> dd: writing to 'someoutput': Disk quota exceeded
>>>>> 2467+0 records in
>>>>> 2466+0 records out
>>>>> 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
>>>>> vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
>>>>> vagrant@localhost:/mnt/loop/abc/mydir3> dd if=3D/dev/zero =
of=3Dsomeoutput
>>>>> oflag=3Dappend
>>>>> dd: writing to 'someoutput': No space left on device
>>>>> 127393+0 records in
>>>>> 127392+0 records out
>>>>> 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s
>>>>=20
>>>> Yes and as I mentioned above this is deliberate.
>>>=20
>>> That may be the historical XFS behavior, but IMHO, it doesn't make
>>> this behavior *useful*.  If *anyone* can change the projid of files
>>> that makes them mostly useless.  They might be OK for informational
>>> or accounting purposes (e.g. fast "du" of a directory) in a friendly
>>> user environment, but they are useless for any space management =
(i.e.
>>> anyone can easily bypass project limits by "chattr -p $RANDOM =
<file>").
>>>=20
>>> I'd prefer to make the project quotas useful out of the box for =
ext4,
>>> by implementing the chprojid_gid tunable, or something equivalent.
>>> If there are users/sites that want identical behavior to XFS, they
>>> can always set chprojid_gid=3D-1 to allow anyone to change the =
projid.
>>>=20
>>> I'd be happy to understand what Dave doesn't like about this =
proposal,
>>> but the last time the enforcement of project quotas was discussed, =
my
>>> attempt to figure this out ended with silence, see thread ending at:
>>>=20
>>> =
https://lore.kernel.org/linux-ext4/6B0D1F84-0718-4E43-87D4-C8AFC94C0163@di=
lger.ca/
>>>=20
>>> Maybe this time we can get over the hump?  Is it just some implicit
>>> difference between "directory quota" and "project quota" that exists
>>> in XFS that I (and everyone using ext4) does not understand?
>>=20
>> I don't have any particular objection to adding an admin-controlled
>> means to restrict who can change project ids on a file, other than =
let's
>> do this in a consistent way for the three fses that support prjquota.
>=20
> That's my stance in a nutshell. Project quotas are not a "ext4 can
> do whatever they like and screw everyone else" feature.

My intent has *never* been "screw everyone else", and I don't see how
you can read that into "I'd be happy to understand what Dave doesn't
like about this proposal, but the last time the enforcement of project
quotas was discussed, my attempt to figure this out ended with silence."

I'm not trying to introduce gratuitous differences to project quotas,
but you shot down the previous proposal to prevent regular users from
arbitrarily changing project IDs as "a horrible 'designed by an engineer
to meet a specific requirement' interface" without offering a useful
alternative in return.  Maybe I misunderstood and you were describing
the current XFS project ID behavior of allowing users to change the
project ID to anything they want, your comment wasn't specific? :-)

Clearly there is a need to be able to prevent users from changing the
projid of files, as it's come up a number of times already.

> New features for project quotas *must* be consistently managed and
> provide -exactly the same semantics- across all filesystems that
> support project quotas. That means new management features is *must*
> be supportable by all filesystems and implemented *in the same
> patchset* for all filesystems that support project quotas.
>=20
> Fragmenting the functionality space because "ext4 does not play well
> with others" is not acceptible anymore. If you implement
> functionality that other filesystems support and then want to extend
> it, you need to bring all the other filesystems along with ext4.

The original proposal was never "let's change ext4 project quotas to
be fundamentally different from XFS", but rather "here's an *option*
to fix what several users have reported as an issue with project quota
behavior (being able to change the projid arbitrarily), with the
ability to revert to the existing project quota behavior that XFS
has for archaic reasons, if needed".

>> Personally, I thought Dave was stating how we got to the current
>> prjquota implementation w/ non-entirely-intuitive Irix behavior and =
then
>> asked for a concrete definition of new behavior + patches and was
>> waiting to see if Wang or someone would send out f2fs/ext4/xfs =
patches...
>=20
> Yup, that's pretty much it.

The intent of the previous thread, and this one as well, is that it =
seems
the ext4 developers *don't understand* the Irix/XFS semantics of project
quotas vs. directory quotas, and I was asking for clarification on what
the difference between "project quotas" and "directory quotas" as exists
n XFS today (if there is a difference)?

Is it "directory quotas have PROJID_INHERIT", and "project quotas do =
not",
but this has nothing to do with quota *enforcement* (which is =
nonexistent)?

Do files created in directories with a project ID set, but *not* having
PROJID_INHERIT, still inherit the projid, but this isn't enforced?  That
doesn't seem to be the case.

Is it that files and subdirectories in directories with PROJID_INHERIT =
set
can only be changed by the root user in the init namespace, but if the
parent does not have PROJID_INHERIT set then users in the init namespace
can change the projid of any file that they can write?  That also =
doesn't
seem to be the case.

I ran some tests on XFS and couldn't see any way to prevent a regular
user from changing the projid arbitrarily with chattr, so it doesn't
*appear* to be a quirk with how project quotas is implemented by ext4.
Is there some mechanism/option/xfs_quota magic that *prevents* users =
from
changing the projid that I'm missing?

Cheers, Andreas






--Apple-Mail=_6BF613E4-61FE-452C-B1D6-60BBB8E5E8C0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6xvxAACgkQcqXauRfM
H+DAdQ//RakRdxnpse5adwzdKScAc0sW9q3QquUDcQEm4V2BL278nkb7Q/+9saZf
8TWDN9t13kHUPx0VMrF69dbBWWlL487ZIUM/dwLUPX8vP2ogMzHCpqStbuGdomo/
C/GtFsX3Q8Mojp/9Y8eX3rRrTZ/th2HvD5HfVg2m2sDcxXH20md4jogZvIHfDFTS
SzC2bamULSBuLAOCdT+w1oAexXWw7yoOeWWjgNZHJkd69/kVIRKlTkhE1/2ZJ1sQ
L9OZPwf+mMhjIbps02+gqLDG8sgrpJxByxN6BYBSXfRO3e0a3BIOTj4HAQ++XJEa
Pyh0JJZrvLymgHU412AxdVRI2tLJYMmjDpBpd/5KFhyS62anhrmdu8bq/sOW/RjG
iOXIRzAhzNcFJtjEx3stKex2mQg6Ksft8EHqeaFrHVY8+Xfg32EGdxOEMH7BkBC+
DR7rHDc6b78mvnK18eNayuFYEltMUnGsajgPudeyxB3LElNc4ocaxJlqnSWIoyWd
MzGBKScJnePDaofj+0NoK4seJcf/uIWTqqdqkCp3FY7Tkc21UhkeYhDYvZyfrgLx
Tcw4TnkGRdhUxbUwhQOBLVGzbrRUIBbMbK7mp4cHm6K/Zk4gqHqPZ07fxnmmMgyk
1pC6XmeBybGMeYyxySj2+qEKeENsMYdWR83wct0QCvx+OkUiIgk=
=jZcF
-----END PGP SIGNATURE-----

--Apple-Mail=_6BF613E4-61FE-452C-B1D6-60BBB8E5E8C0--

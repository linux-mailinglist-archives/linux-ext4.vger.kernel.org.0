Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45C4107B90
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Nov 2019 00:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVXrF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Nov 2019 18:47:05 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36116 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfKVXrF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Nov 2019 18:47:05 -0500
Received: by mail-pj1-f67.google.com with SMTP id cq11so3729223pjb.3
        for <linux-ext4@vger.kernel.org>; Fri, 22 Nov 2019 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+dRsAjczbFl2wwm3a4KpTFtolkCqfrX4V6Zd0tN3vvg=;
        b=hRqcgpmlEw4jKhZQQBMQoRgef/9OQm4YJhNzWLDhPhKeJn5v7nhHRfpjJuK9RQyka7
         1L4U+L99Gvw3N+5hQPYXdWtZkPaVo7BA2QxNrdkx7PgayUxSiPSAOP+kdugGJ3zTfuY5
         RUKv78XEkLFLjMGZG5q2XjHSY6qHB/Ovb2xvVWk+j5sJ5O5JdCg5zAGQOyqSYdxJk/SV
         ebGoZWFmQltGsqggOpb5B+WXMLiI/x7y21EMsQ1pD/VjYl7vLbSqJFMMSZRmqGHmTOVw
         R5k1UjkpBLjzOhi+VZ8xFptILSMb86SgFVzqText1tTy5jcmanXzrnzDm9ctxObu9n2a
         z7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+dRsAjczbFl2wwm3a4KpTFtolkCqfrX4V6Zd0tN3vvg=;
        b=CgPF1/YIiQ6YLo4BHdlANXuQHdOAVxqByenOBAQZX6+jg0pkrI/hinVZjDE7Mx7/FS
         8TSH1QWPM73YAQLFkE9f++lsnTCtIZ5AjTr9gncE9Q9Ny2OEkCJ3MPQb/tvQEDiD0tsZ
         Y0cdQeZiT/AukCW1+inIfXXRkVvMNY+VCg5HG7qTTydTpHUm2+xuVYI+INZHxfvc+Icx
         viBSvlSlVoKbl/NYotO/eGcVU95N4hlWeNZMr1JbYNwRwJo3wmtelzdl2MoyFMbf+xQd
         6UvppzkIwfjL7rKmSgl+iy8r4eODUCKAnxibpIG2DpCLUeTbOD5MNvzydZQShQWaf853
         Mugg==
X-Gm-Message-State: APjAAAXYTfF316nH+7uQf0G1zug9UTiHJSjirUTc7+izpskugsJLSzJv
        C+Ipm1Sm/+lwK+XEZrns2lIM0A==
X-Google-Smtp-Source: APXvYqwdeIsMlxd70uYsaEqVZUtzChs7s+oiN9o7Dg8L7T9iChzN2jdGRbcnKYg8A8KQ4mHDvdfwMw==
X-Received: by 2002:a17:90a:a4cb:: with SMTP id l11mr2178317pjw.47.1574466424445;
        Fri, 22 Nov 2019 15:47:04 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u18sm8298971pfn.183.2019.11.22.15.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:47:03 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <681B8DB8-0B1E-43FA-B28B-95D1B007D158@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_252E5379-00F8-46DE-A818-09ABC936DDBE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: simulate various I/O and checksum errors when
 reading metadata
Date:   Fri, 22 Nov 2019 16:46:59 -0700
In-Reply-To: <20191122000933.GG6213@magnolia>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20191121183036.29385-1-tytso@mit.edu>
 <20191121183036.29385-2-tytso@mit.edu> <20191122000933.GG6213@magnolia>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_252E5379-00F8-46DE-A818-09ABC936DDBE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 21, 2019, at 5:09 PM, Darrick J. Wong <darrick.wong@oracle.com> =
wrote:
>=20
> On Thu, Nov 21, 2019 at 01:30:36PM -0500, Theodore Ts'o wrote:
>> This allows us to test various error handling code paths
>>=20
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> ---
>> fs/ext4/balloc.c |  4 +++-
>> fs/ext4/ext4.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
>> fs/ext4/ialloc.c |  4 +++-
>> fs/ext4/inode.c  |  6 +++++-
>> fs/ext4/namei.c  | 11 ++++++++---
>> fs/ext4/sysfs.c  | 23 +++++++++++++++++++++++
>> 6 files changed, 84 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
>> index 102c38527a10..5f993a411251 100644
>> --- a/fs/ext4/balloc.c
>> +++ b/fs/ext4/balloc.c
>> @@ -371,7 +371,8 @@ static int ext4_validate_block_bitmap(struct =
super_block *sb,
>> 	if (buffer_verified(bh))
>> 		goto verified;
>> 	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
>> -			desc, bh))) {
>> +						    desc, bh) ||
>> +		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
>> 		ext4_unlock_group(sb, block_group);
>> 		ext4_error(sb, "bg %u: bad block bitmap checksum", =
block_group);
>> 		ext4_mark_group_bitmap_corrupted(sb, block_group,
>> @@ -505,6 +506,7 @@ int ext4_wait_block_bitmap(struct super_block =
*sb, ext4_group_t block_group,
>> 	if (!desc)
>> 		return -EFSCORRUPTED;
>> 	wait_on_buffer(bh);
>> +	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
>> 	if (!buffer_uptodate(bh)) {
>> 		ext4_set_errno(sb, EIO);
>> 		ext4_error(sb, "Cannot read block bitmap - "
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 1c9ac0fc8715..e6798db4634c 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1557,6 +1557,9 @@ struct ext4_sb_info {
>> 	/* Barrier between changing inodes' journal flags and writepages =
ops. */
>> 	struct percpu_rw_semaphore s_journal_flag_rwsem;
>> 	struct dax_device *s_daxdev;
>> +#ifdef CONFIG_EXT4_DEBUG
>> +	unsigned long s_simulate_fail;
>> +#endif
>> };
>>=20
>> static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
>> @@ -1575,6 +1578,45 @@ static inline int ext4_valid_inum(struct =
super_block *sb, unsigned long ino)
>> 		 ino <=3D =
le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
>> }
>>=20
>> +static inline int ext4_simulate_fail(struct super_block *sb,
>> +				     unsigned long flag)
>=20
> Nit: bool?
>=20
>> +{
>> +#ifdef CONFIG_EXT4_DEBUG
>> +	unsigned long old, new;
>> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>> +
>> +	do {
>> +		old =3D READ_ONCE(sbi->s_simulate_fail);
>> +		if (likely((old & flag) =3D=3D 0))
>> +			return 0;
>> +		new =3D old & ~flag;
>> +	} while (unlikely(cmpxchg(&sbi->s_simulate_fail, old, new) !=3D =
old));
>=20
> If I'm reading this correctly, this means that userspace sets a
> s_simulate_fail bit via sysfs knob, and the next time the filesystem
> calls ext4_simulate_fail with the same bit set in @flag we'll return
> true to say "simulate the failure" and clear the bit in =
s_simulate_fail?
>=20
> IOWs, the simulated failures have to be re-armed every time?
>=20
> Seems reasonable, but consider the possibility that in the future it
> might be useful if you could set up periodic failures (e.g. directory
> lookups fail 10% of the time) so that you can see how something like
> fsstress reacts to less-predictable failures?
>=20
> Of course that also increases the amount of fugly sysfs boilerplate so
> that each knob can have its own sysfs file... that alone is half of a
> reason not to do that. :(

Just for comparison, Lustre has had a fault injection mechanism for ages
that can do a bunch of things like this.  Each fault location has a =
unique
number (we separate them by subsystems in the code, but numbers are =
rather
arbitrary), and then a sysfs parameter "fail_loc" that can be set to =
match
the fault location to inject errors, and "fail_val" that allows =
userspace
to adjust/tune the failure behavior (e.g. only affect target N, or sleep =
N
seconds, ...).

The low 16 bits set in fail_loc is the fault location number, and the =
high
16 bits of fail_loc are flags that can modify the behavior independent =
of
which failure number is being used:
- CFS_FAIL_ONCE: the fail_loc should only fail once (default forever)
- CFS_FAIL_SKIP: skip the fail_loc the first "fail_val" times
- CFS_FAIL_SOME: trigger the failure the first "fail_val" times
- CFS_FAIL_RAND: trigger the failure at a rate of 1/fail_val

There are also flags set by the kernel when the failure is hit, so it is
possible to read fail_loc in a test script if the failure was already =
hit.

Internally in the code, the most common use is just checking if we hit =
the
currently-set fail_loc (which is unlikely() for minimal impact), like:

	if (CFS_FAIL_CHECK(OBD_FAIL_TGT_REPLAY_RECONNECT))
		 RETURN(1);	 /* don't send early reply */

        if (CFS_FAIL_CHECK(OBD_FAIL_FLD_QUERY_REQ) && req->rq_no_delay) =
{
                /* the same error returned by ptlrpc_import_delay_req() =
*/
                rc =3D -EWOULDBLOCK;
                req->rq_status =3D rc;

It is possible to inject a delay into a thread to allow something else =
to
happen (maybe more useful for a distributed system rather than a local =
one):

	CFS_FAIL_TIMEOUT(OBD_FAIL_TGT_REPLAY_DELAY2, cfs_fail_val);

It is also possible to set up a race between two threads in the same or
different parts of the code on the same node:

	CFS_RACE(CFS_FAIL_CHLOG_USER_REG_UNREG_RACE);

The first thread to hit this fail_loc will sleep, and the second thread
that hits it will wake it up.  There is a variation of this to make it
explicit that only one thread to hit a location should sleep, and a
second thread needs to hit a different location to wake it up:

	thread1:
	CFS_RACE_WAIT(OBD_FAIL_OBD_ZERO_NLINK_RACE);

				thread2:
				=
CFS_RACE_WAKEUP(OBD_FAIL_OBD_ZERO_NLINK_RACE);

It is also possible to daisy-chain failure conditions:

	if (ns_is_client(ldlm_lock_to_ns(lock)) &&
	    CFS_FAIL_CHECK_RESET(OBD_FAIL_LDLM_INTR_CP_AST,
				 OBD_FAIL_LDLM_CP_BL_RACE | =
OBD_FAIL_ONCE))
		ldlm_set_fail_loc(lock);

so here if "OBD_FAIL_LDLM_INTR_CP_AST" is hit, it will reset fail_loc to =
be "OBD_FAIL_LDLM_CP_BL_RACE" to fail once, flag a particular DLM lock =
and then
the next two threads that access this lock will race to process it:

	if (ldlm_is_fail_loc(lock))
		CFS_RACE(OBD_FAIL_LDLM_CP_BL_RACE);

The CFS_FAIL functionality has been used for quite a few years and has
proven sufficient and easily used to invoke failure conditions that =
would
be otherwise impossible to reproduce (over a thousand fault injection
sites in the Lustre code and corresponding tests to trigger them today).

Cheers, Andreas






--Apple-Mail=_252E5379-00F8-46DE-A818-09ABC936DDBE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3Yc3QACgkQcqXauRfM
H+C9iRAArf7NXjPvaY4SkClwTNQ2TaIwpTF5rhOiVr9urU7mhXRhm+GGpQTp146n
34PusjbAOCu3cLm5BaSyxASwI2IbG+tbAvVt79kJjROzXa1zJgRz4Z9vAbH+MdKV
5dpX8Q0fdBxi0RS7lDhsF/jFIOnWQ37JmoTd7nWp538vIuQYuNIP/s4AjF9YWhHt
IK0wJjklQgfjdsODd20DG+NQ0VpPMomPCoyw7QJVdHaSiKbz+TMzNXVws8Y3vqRX
mZdiLdTHgWbQ1/kRGwXv7lwSAZZ3JusvmFxErFOktXJijFF6jFqGrT3Z6e/v8/z2
UZVsc01cktomTA7tw9yy11GhKDNwUQ4/xbd6lzSIyeuySFFsiQPaeRmwJTUhUzvN
YucqMoJo+r4JriuAVU9EEEFEOu5E7fAh0xiQP7kN1YAds4t3zXnujKUw0s7tUIHq
5SH8jmc9Yr84UX961gKQ4UhGng3+1RgwyO51Fufxuimq48Il22nmxAFTw//aFJ5g
HBuG1j/cLL33lesG+gzswmXqeRv8rsyjDsZ/WAfdSWHHDkhgcRidRjxNviNPvovc
+AWhGX1Jn2cjgO+zKfASIYnfZtWHNpr8VveAstaVaVJx69HAMZzZebtiur9J0bOh
dLKQqeG9EkUcWamXr0bZoKMLVchwInUvp9ZtNfsVGSzFZWzP0OM=
=kxDo
-----END PGP SIGNATURE-----

--Apple-Mail=_252E5379-00F8-46DE-A818-09ABC936DDBE--

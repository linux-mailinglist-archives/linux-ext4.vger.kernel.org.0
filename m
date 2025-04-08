Return-Path: <linux-ext4+bounces-7143-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23733A815B7
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F241B84055
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038FA158DD8;
	Tue,  8 Apr 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCrlFSlo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AA150980
	for <linux-ext4@vger.kernel.org>; Tue,  8 Apr 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139908; cv=none; b=tzhdjXOdpIUNsrtkEw5YUvMTBvch3diUEXOZG0KO33ybntrB1d+CqPB7x2u7++SxSb+O/QCW2OU6TjuvbmMqqhnQozOVlXr5IjjHhjEosEVSf3DiJGHAqDEjNGhw41euWAPyAc2hovLzvsSXtYmbMQi6jQ21Wh4k0AtarliQlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139908; c=relaxed/simple;
	bh=0LQvWw2ZdAqQeqKLy8YkDmnqDcqXz/xLnpz/IWqsfeU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JNfU3JFVdOJGIuTOg7HQG89dfdhBjvv7/dgezOMRpDapT/yGFUsxRknuvB/sl80KuJ+E3OJQ0zMtqgyQFkf9Gbpd/JKo13b6pk5SLT3cqBUNwiX90bC83fDBQ6KD0JBIVkj+P6bep7B7eyPyoxsT5JaxEJL8rpNjlNXLKgdRC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCrlFSlo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso65023065ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744139906; x=1744744706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzJ1tlbNZbz8HW2V590et3TpvKdxezN+w4lwgvpwvA4=;
        b=LCrlFSlo/qAAasCM6W+bI2pQ7jIJmKhGj4mbSSOdV67hASHJ6CoEmNYiNuCRZVbRvF
         IM8i7MJzhzDhI5W2XHqNYWuMoCPkGyVk7AB/RKeCgjh3nax1JqXBmq9m8rfCku2OaEBh
         mZ/I52lNDwEsif2fiRDOPjorSXaBdGfsf8+O4cjgUih56uh+Zza3UQuOnh450y8cKD49
         io2MXdLBWkURIsJXbb1twIfFlaVhmDa2u+25BZBwHeIVir+vvhG36gblvxR4iA1LHG2Y
         z4GVUwB/+teL5nswAomJ1ZHVIyfZSykYpeTg2pbn0LINUzz8G8gzjaTxspggNTKOVNAG
         v/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139906; x=1744744706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzJ1tlbNZbz8HW2V590et3TpvKdxezN+w4lwgvpwvA4=;
        b=cegaq84jtRBk68CKtAUUBfJhaVKUcEtzQPHmkpb7kKT7DFJ3BrpwUn2d5Fyvg8Hwd+
         ij6ua9ohIrQv6k8mk+CQDLlhWXSQFe4nN+xmEcV3BkC43i47HhvwRro7DMIustWp9G9x
         fZzIxypepv7878BoKlj5dNK18gyjGQfcYFNhES5Kk2KfG5S/LyqhEWkKV3uU8BlDQsfw
         36fHFpNPNvKTex7DsAzYFhfPWizTjMFZAx08dk73F79hDxNZ9JwbKTgBL0TfXXKcWBa3
         UcbcUx4+w0qkleJz/oCAUwgNNnT+soaGri47FvsEEVxoR/gwiv22coM9rDiWkre3fDDP
         OE6Q==
X-Gm-Message-State: AOJu0YzliCxH5BrNK4LyDmlD0abzOy3wYXxC7rc/158SOnRFo2rPqIOR
	8Z1AqQnjZ5LAikMWNxFsXyoxDLTQorLJy5+4zVppqHlXqZnh+i1jHyZ76mvMgFBDPALXSJoOa4N
	MjVMeaTSmvEHtj2Uzb46FfhZwI6Rp6FB3YcY=
X-Gm-Gg: ASbGnct7VF4KvkrQw8yZemh2N5x6Vyf7imPRjs+gytyeTlM/BYUvo4U8yteFA2MhMas
	owOEANEuQYvxOF2XABOvnFzIOstwMTO/zI89JsUUly+jPovl6CRlE8yMMw9UHC7qZ4e/Ar3eIBc
	PFhvtafa9I1tbOqOsjI9k8l3OyMOk=
X-Google-Smtp-Source: AGHT+IFqhN9hFS5Lf/ZaypRQLBHWC67ckaKG8WG6Ud8O5TBIqcuY3hSaHcAuzs/7gDSB7FH/SwhSJeIt+//il7lhAbw=
X-Received: by 2002:a17:903:2306:b0:223:5a6e:b20 with SMTP id
 d9443c01a7336-22ac298f91emr4892285ad.7.1744139906170; Tue, 08 Apr 2025
 12:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pravin Shedage <pravinshedage2008@gmail.com>
Date: Wed, 9 Apr 2025 00:47:49 +0530
X-Gm-Features: ATxdqUFbr5pDbgW8Io9sRv0LEJ7rl52W6kg4hJED-Vy3snO-1ThcEEOLBfuAkP8
Message-ID: <CABzL1gYnYrLQsEMOUY27XvcR3ZLnnOmrPv=_fHPNwJ3v+Mrg6w@mail.gmail.com>
Subject: Help with Real-world Usage of ID-Mapped Mounts with Docker on Ubuntu 24.04
To: linux-ext4@vger.kernel.org
Cc: brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,
Hi ext4 mailing list,

I'm currently exploring the ID-mapped mount feature in a real-world
scenario and looking for guidance on setting it up in combination with
Docker containers on an Ubuntu 24.04 host (kernel 6.8).

My goal is to use ID-mapped mounts with an ext4 filesystem to achieve:

- Seamless user access (no need to chown directories to match container UID=
s)
- Security (containers see files as "owned", but the host retains real
ownership)
- Multi-user safety (same directory can be exposed to different
containers with different user views)
- Mount once, map many (flexibly remount the same data for different
users securely)

I have referred to the LWN article =E2=80=9CUser ID mappings and mounted
filesystems=E2=80=9D (https://lwn.net/Articles/896255/) to better understan=
d
the feature and its intended use cases.

### Setup

On the host:
$ ls -l /mnt/ext4/users/
drwxr-xr-x 3 test1-user test1-user 4096 Apr 8 12:14 test1-user
drwxr-xr-x 2 test2-user test2-user 4096 Apr 8 10:57 test2-user

Created two ID-mapped bind mounts:
$ sudo mount --bind -o X-mount.idmap=3Db:0:1001:1
/mnt/ext4/users/test1-user /mnt/ext4_1
$ sudo mount --bind -o X-mount.idmap=3Db:0:1002:1
/mnt/ext4/users/test2-user /mnt/ext4_2

$ mount | grep /mnt/ext4
/dev/vdf on /mnt/ext4 type ext4 (rw,relatime)
/dev/vdf on /mnt/ext4_1 type ext4 (rw,relatime,idmapped)
/dev/vdf on /mnt/ext4_2 type ext4 (rw,relatime,idmapped)

Docker subuid/subgid are configured:
$ cat /etc/subuid
pravin-user:100000:65536
test1-user:165536:65536
test2-user:231072:65536

Scenario 1: ID-mapped mount used in container (FAILS)

docker run -it --rm --userns=3Dhost --user 0:0 \
  --mount type=3Dbind,source=3D/mnt/ext4_1,target=3D/mnt/ext4_1 \
  test-container bash

Inside the container:
# ls -l
drwxr-xr-x 2 nobody nogroup 4096 Apr  8 12:14 dir1
-rw-r--r-- 1 nobody nogroup    0 Apr  8 12:14 file1
# touch file2
touch: cannot touch 'file2': Value too large for defined data type

Scenario 2: Using unshare with ID-mapped mount (FAILS)

$ sudo mount --bind -o X-mount.idmap=3Db:0:1001:1
/mnt/ext4/users/test1-user /mnt/ext4_1
$ sudo unshare -Urnm bash
# docker run -it --rm --mount
type=3Dbind,source=3D/mnt/ext4_1,target=3D/mnt/ext4_1 test-container bash

Same "Value too large for defined data type" error occurs when trying
to write to the directory.

Scenario 3: Map directly to container UID (WORKS, but defeats purpose)
$ sudo mount --bind -o X-mount.idmap=3Db:1001:1001:1
/mnt/ext4/users/test1-user /mnt/ext4_1
$ docker run -it --rm --userns=3Dhost --user 1001:1001 \
  --mount type=3Dbind,source=3D/mnt/ext4_1,target=3D/mnt/ext4_1 \
  test-container bash

This works (I can create files), but it doesn't use the 0-based
remapping that ID-mapped mounts are designed to provide=E2=80=94so the
flexibility and isolation benefits are lost.

Question

Is there a recommended way to make ID-mapped mounts usable inside
Docker containers in this scenario?
- Am I missing a userns configuration in Docker that would allow the
container root (UID 0) to correctly map to the host UID used
  in the bind mount?
- Should the bind mount target be made inside a container-specific
user namespace before starting the container?
- Or is this a current limitation of Docker's handling of user
namespaces + idmapped mounts?

I'd really appreciate any pointers on making this work in a secure,
multi-user, real-world container setup.

Thanks a lot for your time and for all the work on this feature=E2=80=94it =
has
great potential for secure container setups!


 Thanks & Regards
         PraviN


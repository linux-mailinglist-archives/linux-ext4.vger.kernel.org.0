Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3514B28F404
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 15:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgJON4m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 09:56:42 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:40845 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbgJON4m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 09:56:42 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 09:56:37 EDT
Received: from [129.217.43.37] (kalamos.cs.uni-dortmund.de [129.217.43.37])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 09FDuSAK004364
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Thu, 15 Oct 2020 15:56:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1602770188;
        bh=lYyynSAve4cbZZYNd/ZFmP1/MBwQVccJHoLZwJdRReA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VWIT+Te8qI3g9B0IVQwLzR5iePi4GJajSiTfRbrbzBneOrEoiOA+5hZ+ecfm+rh2L
         KTGT5tRKYb+4bdfXBPR4/wjmFhyx46ZfwXMy7F+8GF8Ff72wsoYUEjLDoPtYDbwJ9i
         sm1fiSnVl8x/Moq6SHyXR40Zj9NYS4DWdiV2gnbU=
Subject: [RFC] Fine-grained locking documentation for jbd2 data structures
To:     tytso@mit.edu, Jan Kara <jack@suse.com>
Cc:     Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        linux-ext4@vger.kernel.org
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Autocrypt: addr=alexander.lochmann@tu-dortmund.de; prefer-encrypt=mutual;
 keydata=
 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
 VhopshUAQ+v/CLESeUrxbP19Qw==
Message-ID: <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
Date:   Thu, 15 Oct 2020 15:56:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="5aaLMZEaWne1lsSTRaeyvSGwijYHiZN5w"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5aaLMZEaWne1lsSTRaeyvSGwijYHiZN5w
Content-Type: multipart/mixed; boundary="ZIpBuFy3Xfl5278FczjeC7eVYnAWSmQfg";
 protected-headers="v1"
From: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
To: tytso@mit.edu, Jan Kara <jack@suse.com>
Cc: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
 linux-ext4@vger.kernel.org
Message-ID: <7827d153-f75c-89a2-1890-86e85f86c704@tu-dortmund.de>
Subject: [RFC] Fine-grained locking documentation for jbd2 data structures
References: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>
In-Reply-To: <20190408083500.66759-1-alexander.lochmann@tu-dortmund.de>

--ZIpBuFy3Xfl5278FczjeC7eVYnAWSmQfg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi folks,

when comparing our generated locking documentation with the current
documentation
located in include/linux/jbd2.h, I found some inconsistencies. (Our
approach: https://dl.acm.org/doi/10.1145/3302424.3303948)
According to the official documentation, the following members should be
read using a lock:
journal_t
- j_flags: j_state_lock
- j_barrier_count: j_state_lock
- j_running_transaction: j_state_lock
- j_commit_sequence: j_state_lock
- j_commit_request: j_state_lock
transactiont_t
- t_nr_buffers: j_list_lock
- t_buffers: j_list_lock
- t_reserved_list: j_list_lock
- t_shadow_list: j_list_lock
jbd2_inode
- i_transaction: j_list_lock
- i_next_transaction: j_list_lock
- i_flags: j_list_lock
- i_dirty_start: j_list_lock
- i_dirty_start: j_list_lock

However, our results say that no locks are needed at all for *reading*
those members.
=46rom what I know, it is common wisdom that word-sized data types can be=

read without any lock in the Linux kernel.
All of the above members have word size, i.e., int, long, or ptr.
Is it therefore safe to split the locking documentation as follows?
@j_flags: General journaling state flags [r:nolocks, w:j_state_lock]

The following members are not word-sizes. Our results also suggest that
no locks are needed.
Can the proposed change be applied to them as well?
transaction_t
- t_chp_stats: j_checkpoint_sem
jbd2_inode:
- i_list: j_list_lock

Cheers,
Alex

--=20
Technische Universit=C3=A4t Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al


--ZIpBuFy3Xfl5278FczjeC7eVYnAWSmQfg--

--5aaLMZEaWne1lsSTRaeyvSGwijYHiZN5w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElhZsUHzVP0dbkjCRWT7tBbw+9v0FAl+IVQsACgkQWT7tBbw+
9v2inxAA2QNkV3eBMGJT3bHys98HhaADAaDl450WYfPIzdP8MSsTM+n2ALhH6Kr6
nPOwMF6C9jbWYEkUtHtJvqfzGdoNrDFQ8c2OEOQl95V291NUh4Iu1Ri2TQLJlVhG
D9mHcFCDGgUm8r/Rjl7rHo6NnBlhQ1c1kUt/fV1HkvrMrfAxHdhtnZwGYePcrVgX
whhivOE1MH0hUq5QK/w4rVjAxG0KBUETcU5pklFFjwS3SWoghUYmzMzNA1mhO5Ue
A+wl1oRVbcoGp50Kag1iUU4RXPpuIK2oFtFG/FqxT/3p+wCNZV3Qwi9GYExeQ2tH
8d2jTqej+efeaytDXPU8tJiJ1DVR/agG6M0Ngsy+2WQco39pczhtmN9E54rlwqkg
Ndo667LBpmamKl6ZVTDh7lA2o92v2g/HB46X+WEe5GCbv/yRHAxjGlbCN+ptZn3b
Vgr7WtsRreo3HDAn3FCNGKaeOCI0CggXZS3SIO/DuZUh01UZTN5cJf0I51fNcPZP
eHtnvRSmwL1x2t3in68N416Y6kaqGuyTT6Y2CyPq9Kkmu3mQ1YEjm0Zvvb3puRnU
ogrbbtF2HfXYJbwDIy34EdXWiQtYHttJaCynITc685Vg56KRuhw+JIsES6hWcDQP
NmaHzZ5ppP/u7lS2ytQv81PLomfwPqi3DpI/36OCxVTnJM7MefE=
=DdFt
-----END PGP SIGNATURE-----

--5aaLMZEaWne1lsSTRaeyvSGwijYHiZN5w--

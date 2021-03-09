Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0B3320DD
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Mar 2021 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCIIiC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Mar 2021 03:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhCIIhd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Mar 2021 03:37:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DA3C06174A
        for <linux-ext4@vger.kernel.org>; Tue,  9 Mar 2021 00:37:33 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id e26so354796pfd.9
        for <linux-ext4@vger.kernel.org>; Tue, 09 Mar 2021 00:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=d1+wbF0j08C+yL4Qf8QuTk/3dXhKr0P2IBG3NrZNn9Q=;
        b=n3BlyJOBBIGn8JVpaduxZDMXheYNWB1K1ySMBZldbJLO3fmcm/jb1qc0VN2D4lilIo
         BeFqE30+gZd0QsJgTsGNntmhu3sYz/XV1vJ0rKMucUcoGAhacgJqESF/CIM7cjfVFl5s
         9v2OqNrQlyAZbyZ9z3uqPZ/JpsDkN9BnFHpzQq66wr5BTvz1A3EHZj4hqYGEerImZViM
         0NSnKfLL0ijSTMZFmsA8TqE6rsIDsquBNar8nVMWrnEN7GRuuIKYaJQ0E0B2GAOKYBBh
         DJfFogLUePZ49zk08ieP3oOJXrdXQUsTWxVwwK44vbuLnvWhyI8mnC+XX4DgC10Dft1d
         +ceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=d1+wbF0j08C+yL4Qf8QuTk/3dXhKr0P2IBG3NrZNn9Q=;
        b=tRAc6Yp96I1WzVl0q9WwqlP3SYYQ2ZECGjVhpeHDVEE16Bho1nZFmzBYyEzDdPmU2i
         CCxu+gIm+n7K9Eu3m1rzCRcp3d9Pc1qnMMFf7yWdcVnCItHnP7xH36LA3zSCeireqPUU
         s9UK5eAMttT//6vnDEpktYdhZZSm9ZS7f0AcX3glDME1Kp2qVGE48034RGXjkPXl/Iua
         jQdetGPlz136B5M8avNhcofVyaQsa+zNxw3jF0OZq0RUOIFm52nyM1kygyK2tn0JLrKY
         T/7QTv8oEwhSNJbuCl4vWsmKJGioA55D0bhvo15xdM1pEKPqnaKTsOkvHrrg51h2bxNM
         kn1w==
X-Gm-Message-State: AOAM533keJeuJTT6q+L0wHU45TbqAoVOKfeIDJfsthiaXH0t38iv5CiX
        Wmdpwyu65iDSd8nGzaS7aOJYXmUsvkVVRvwu
X-Google-Smtp-Source: ABdhPJx6c2JrGN1Qx4mIMw1OyvctAQglOQPc/hr+ZHy49ienLh7Nl8Ec3G+VmKzUBYlGl8KEg1dX0Q==
X-Received: by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id h16-20020a62b4100000b02901a478687e4emr25398623pfn.62.1615279053122;
        Tue, 09 Mar 2021 00:37:33 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id p190sm12200574pga.78.2021.03.09.00.37.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 00:37:32 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <54EF20C1-1BBF-4BC4-95CA-5FEEFEDE7F2F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_957C513D-66E3-4700-B3B1-1BDA23DFA1E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Scrubbing filenames from meta-data dump of ext4 filesystems
Date:   Tue, 9 Mar 2021 01:37:29 -0700
In-Reply-To: <YEaZ4RL3ZfXB8jdw@mit.edu>
Cc:     George Goffe <grgoffe@gmail.com>, linux-ext4@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <CALCFxS7EwQbF47GNgaiuOVrw0n=OQBzHTH6JpoeiZ=tb1CYB1g@mail.gmail.com>
 <YEaZ4RL3ZfXB8jdw@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_957C513D-66E3-4700-B3B1-1BDA23DFA1E5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Mar 8, 2021, at 2:40 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> On Mon, Mar 08, 2021 at 12:01:46PM -0800, George Goffe wrote:
>> Howdy,
>> 
>> I'm helping to shoot a bug on a Fedora Core 35 system and have been
>> requested to provide a meta-data dump of the problem filesystem. The
>> filenames are restricted so I need to scrub this file  before sending
>> it.
>> 
>> Does ext4 have a facility whereby I can scrub the filenames from the dump?
> 
> Yes, please see the following excerpt from the e2image man page:
> 
>    This will only send the metadata information, without any data
>    blocks.  However, the filenames in the directory blocks can still
>    reveal information about the contents of the filesystem that the
>    bug reporter may wish to keep confidential.  To address this
>    concern, the -s option can be specified.  This will cause e2image
>    to scramble directory entries and zero out any unused portions of
>    the directory blocks before writing the image file.  However, the
>    -s option will prevent analysis of problems related to hash-tree
>    indexed directories.

I had actually looked for this option in the e2image man page in order
to reply to this email, but I couldn't find it and wondered if I had
mis-remembered the existence of this functionality.

I've pushed a patch that reorganizes the e2image man page to list all
of the options explicitly in a separate OPTIONS section, rather than
putting them inline in the text, which makes it hard to find them.

Cheers, Andreas

> The -s option can be used with the -r and -Q options to e2image, for
> creating raw and qcow2 image dumps, respectively.  Because the
> filenames have been scrambled, this will invalidate the hash-tree
> indexes for the directory, so e2fsck will complain about this.  But
> for some kinds of corruption, the -s option can provide data when the
> customer would otherwise not be willing to provide a metadata-only
> dump of the file system.
> 
> Hope this helps,
> 
> 				- Ted


Cheers, Andreas






--Apple-Mail=_957C513D-66E3-4700-B3B1-1BDA23DFA1E5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBHM8oACgkQcqXauRfM
H+DzTA//SedECJzxHw9tB8zVIFc8ZdIlG6g5WkuOjJ52g86KQz1QmSBhkMel9ZNy
QT7uqOT8iLqNT0ijnoQP/PAWeLl+t6NmUs7ZYhQiLwrmUK+90igqD8etIJuLWO38
v5/+/RP6P+ouvQLH7sEGZcDqk/54vWhVK5WSMAQ83fUMQy6ipmk3bHgDEDScUH72
grCV9ibL0sYqLbaEuqG+5YuaxrQrSyphfMCjQ+YbXxVDPOc5/yjWyDmKuGMsIw2c
ft1mK0864+gEiWvpHwtBVL38jZ8YsHpVXtq4ZAqlVrPJ61opv1CvpV4BQgfhPHTn
/DJdNBuG7p6JDLXKvm7mesKNqQd1Yj2F8Bwz38I+BvFhDP1gc2A1QYh6kKukqMuK
HFv+FvTLk98Fn2+lR7vzwAJEzdiduKjwp0yxExb0DEuthQspHLi8YetJiq2yuEm8
OWwiIk26n2GJeMx5mXMjdNR6oKQlzYvDtMwIqy2+FfI68ScR8wuKun2Cpqla1/HM
oe3LKT4AidJd4vuhWedtm7vw0QPjstYrJIQZepgrJjfV1mQB0miPCbaQYcf2ojBj
/fIzr8YsSvUsrxsWR734i0UWqvD6cPV/4X08G6vQ2+pz0ztn9lx9wf/Fju1pXrpG
Jk8Sd46VbpHq6/eqCajjlyqo388MS5FWIP3QmVKxqXx/OQ6hlD8=
=nE7u
-----END PGP SIGNATURE-----

--Apple-Mail=_957C513D-66E3-4700-B3B1-1BDA23DFA1E5--

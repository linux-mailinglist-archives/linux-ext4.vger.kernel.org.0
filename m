Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88227C508D
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJKKv3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjJKKv2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 06:51:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24498
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 03:51:25 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bffc55af02so79555051fa.2
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697021484; x=1697626284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA4VMlVoeOMyOhtKxhGjb50TdmzbdywYsQIBV+11vPc=;
        b=CNQBmY7qVXfQiwZDv4Qq3U01WJ5aeRtlPLzVGnPyLd/BiVFabbJ+TeX7uyzE7frO3Y
         jFjcZTBKKHZhAJfisWg9DqRRYkVYtT0xnAXOQqd4H/pULwY93fxAfrHFG0IYjlg7lfXd
         M6fpqAFJlDI05LovRXR28B7uqsyW0IN+JIspl+RUDl4c2vxgw+BbQCyaXxrvaXhfCjkK
         tOgYT7KgKVUd7DcKqCoSAvhKfxoMe/TN2VfvS6/h2aQjp//kGDBX+EucLdnQJz0/yI5l
         xJEQVJN4zbYfC9b1c32lFEjAPIe3DtE56kQkq/G0KOMsKyDQFziZ1iLsuCLDK8tmo4DO
         WTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697021484; x=1697626284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA4VMlVoeOMyOhtKxhGjb50TdmzbdywYsQIBV+11vPc=;
        b=jwJ2ZF0hFjKx/fzI4By+AJI31UfwG61m3B5kH5wxDmRZrIv2rHucEttDc/5OHy8E3I
         5VPmyW5oWNJBfSRJnoqBCe9oXr4Ervp/lRkLo8dea2T5DW5xMqrZxIzF9n0s+EtTFkpL
         kpLvN7juG5fQhrJTvAvUMWG0btjN1gy31d/XDI98vVuUVeUakV239xOQRUUnG1U6EEkK
         zfJ30s3jjiQxrWING78psLPxLnviVyXPnmb7avgLr07NU49EwwsnmayL+T2Ebf0oB+VI
         Pw3sBtMkijUSPPVwbzYyhAZbdjD0t2481pDZT02wuHnkabPLWk68Q+T0b+R2hAP82jxu
         Tx0w==
X-Gm-Message-State: AOJu0YxMVbJ8qkkhElI8a2C7EkT5aFiagqr/YRC/2zcrc2dKjyyVoLVq
        S4xWmlKPvY25IoV84WRqqOsAxyMJxYYaf98cz1DKPw==
X-Google-Smtp-Source: AGHT+IGyLfs+WkrEIobRRB6LgrkT6il+FVpPUfzkIGExXLDR7euxzATM6T+qlV7Ejvi7bqqDUXFwlj14PNASEvLGAW0=
X-Received: by 2002:a2e:3309:0:b0:2bf:fb49:6619 with SMTP id
 d9-20020a2e3309000000b002bffb496619mr16986300ljc.23.1697021484028; Wed, 11
 Oct 2023 03:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com> <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com> <20231011100541.sfn3prgtmp7hk2oj@quack3>
In-Reply-To: <20231011100541.sfn3prgtmp7hk2oj@quack3>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 11 Oct 2023 12:51:12 +0200
Message-ID: <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
To:     Jan Kara <jack@suse.cz>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 11, 2023 at 12:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> So I've checked some more and the kernel doc comments before
> mode_strip_umask() and vfs_prepare_mode() make it pretty obvious - all
> paths creating new inodes must be calling vfs_prepare_mode(). As a result
> mode_strip_umask() which handles umask stripping for filesystems not
> supporting posix ACLs. For filesystems that do support ACLs,
> posix_acl_create() must be call and that handles umask stripping. So your
> fix should not be needed. CCed some relevant people for confirmation.

Thanks, Jan. Do you think the documentation is obvious enough, or
shall I look around and try to improve the documentation? I'm not a FS
expert, so it may be just my fault that it confused me.... I just
analyzed the O_TMPFILE vulnerability four years ago (because it was
reported to me as the maintainer of a userspace software).

Apart from my doubts that this API contract is too error prone, I'm
not quite sure if all filesystems really implement it properly.

For example, overlayfs unconditionally sets SB_POSIXACL, even if the
kernel has no ACL support. Would this ignore the umask? I'm not sure,
overlayfs is a special beast.
Then there's orangefs which allows setting the "acl" mount option (and
thus SB_POSIXACL) even if the kernel has no ACL support. Same for gfs2
and maybe cifs, maybe more, I didn't check them all.

The "mainstream" filesystems like ext4 seem to be implemented
properly, though this is still too fragile for my taste... ext4 has
the SB_POSIXACL code even if there's no kernel ACL support, but it is
not reachable because EXT4_MOUNT_POSIX_ACL cannot be set from
userspace in that case. The code looks suspicious, but is okay in the
end - still not my taste.

I see so much redundant code regarding the "acl" mount option in all
filesystems. I believe the API should be designed in a way that it is
safe-by-default, and shouldn't need very careful considerations in
each and every filesystem, or else all filesystems repeat the same
mistakes until the last one gets fixed.

Max

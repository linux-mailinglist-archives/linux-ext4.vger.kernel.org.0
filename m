Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2877CD6D7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Oct 2023 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjJRIop (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Oct 2023 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJRIol (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Oct 2023 04:44:41 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79458B6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Oct 2023 01:44:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso11194485a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Oct 2023 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697618677; x=1698223477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaSsFLcqPKcuypC/iOu6bXlu6j7GBqKiOv56w/MwDX8=;
        b=ipzerSW23o/Th6po5kB1072giPX/lh2LjBSfNsRT9LZcEFz1WUbE9GUpRlr41op+bP
         dDnOLQsY8KoyKkHw7vz4C5L7+SxXPgc2NWqALbA3FoWlVFCdARDtI/OSYfOrlthez2WT
         DsVVWz+LDcyvczYu80PxFWfWYQMzkG31AdtVijDN9h6IJZVngHkJ+cBDPDoAxC/b3TBl
         SJi5mIMBcrft8Z5PX3ije2/3ZmjNoVG4V9A13G13Ee+5HtHyK5xyHcvb3ac1CrZ77ign
         drATEawJDJKd9T902Jfcqo2iHe/uc5wh0urVCIibvfFOn8u7QMMdChp6BQFYn/F5GiKI
         THRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697618677; x=1698223477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaSsFLcqPKcuypC/iOu6bXlu6j7GBqKiOv56w/MwDX8=;
        b=pwmg9aUlLrieKU3uAp8UiUrwxWSH5OnpNLWYU9Ss8bjVarY0g/uFJ7vhh37hueshVb
         54pnF07gmocdjsxaE7oP31DXBScNm9dh4cUcM2cq2Wq8A0x4Q/8hPcfNpiwLDxXeZjaq
         XLEISCO/TP55KL+bmYXfRGwcwGUX0GwXtSUBKx0DkiIPDMEFOhbFr2NQcxAHFUxa73MA
         6mG3ZnkebJ6UOngDZ5p86+iQ4pXQK+FkbK85zH6o0Pc0USaYc2PGYGSLXS2yBTJ+lMxt
         IubbUeSr92bN5jiBavQXoLUlDsEsUqAYSLrMfDNU/Kp7UZ12mgRkEvEiBxa14q4H5o8Z
         8JPw==
X-Gm-Message-State: AOJu0YxQiAKz98aWEupQ1474ctP1snccOSt+5pVZ4Gx+ceZsjT69jxX0
        4XxCFnlZVWFzUUJBO4981jv5Dx8tzqW8D+NksI8=
X-Google-Smtp-Source: AGHT+IEdEfU3NNP8gN1Z1My7YiaTKUAcrHLnO6LlW3p2oUiBivp7yabjXqoOLPkQnIwUesNeRvKf/DgoVmyZbL7VHbg=
X-Received: by 2002:a05:6402:40ce:b0:53d:b71d:34a7 with SMTP id
 z14-20020a05640240ce00b0053db71d34a7mr3745385edb.6.1697618676410; Wed, 18 Oct
 2023 01:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230510001409.14522-1-sunjunchao2870@gmail.com> <20FD8461-AEE4-4414-8637-4D1230AB5A20@dilger.ca>
In-Reply-To: <20FD8461-AEE4-4414-8637-4D1230AB5A20@dilger.ca>
From:   JunChao Sun <sunjunchao2870@gmail.com>
Date:   Wed, 18 Oct 2023 16:44:23 +0800
Message-ID: <CAHB1NajnFBSACN3H3tvNSgBn2V9m1AqoOG4kB+0N0ncLj3vCWA@mail.gmail.com>
Subject: Re: [PATCH v2] ext4: Replace value of xattrs in place
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@dilger.ca> =E4=BA=8E2023=E5=B9=B47=E6=9C=8821=E6=97=
=A5=E5=91=A8=E4=BA=94 06:50=E5=86=99=E9=81=93=EF=BC=9A
>
> On May 9, 2023, at 6:14 PM, JunChao Sun <sunjunchao2870@gmail.com> wrote:
> >
> > When replacing the value of an xattr found in an ea_inode, currently
> > ext4 will evict the ea_inode that stores the old value, recreate an
> > ea_inode, and then write the new value into the new ea_inode.
> > This can be optimized by writing the new value into the old
> > ea_inode directly.
>
> Sorry for the long delay in reviewing this patch.
>
> The performance gains are nice, and reducing overhead is always good.
>
>
> > One question about this patch is whether it is safe to overwrite the
> > xattr in place if the system crashes during the overwrite?  That was
> > one of the reasons why the xattr update was implemented by writing to
> > a new xattr inode, and then atomically swapping xattr inode numbers.
> >
> > However, if the xattr overwrite is done via journaled data writes then
> > it would be safe to "overwrite" the xattr data "in place", because
> > data will first be committed to the journal and then checkpointed into
> > the inode itself, so it should never be inconsistent/corrupted.
Thanks for your review. I'm sorry for taking so long to reply..
I checked the relevant code, and ensured that xattr overwriting is
done via journal, so it should be safe.
>
>
> > Did you also test cases where the xattr size is growing or shrinking
> > during the overwrite in place?  That should allocate or free blocks
> > in the xattr inode so that they are not wasted.
> >
Here is a bug in this patch, when xattr size is shrinking, blocks that
were previously allocated but need to be released now will not be
released. Here may need a ext4_truncate to release redundant blocks. I
will check ext4_truncate function and test relative cases, and then
send patch v3.

> Cheers, Andreas
>
> > The logic for replacing value of xattrs without this patch
> > is as follows:
> > ext4_xattr_set_entry()
> >    ->ext4_xattr_inode_iget(&old_ea_inode)
> >    ->ext4_xattr_inode_lookup_create(&new_ea_inode)
> >    ->ext4_xattr_inode_dec_ref(old_ea_inode)
> >    ->iput(old_ea_inode)
> >        ->ext4_destroy_inode()
> >        ->ext4_evict_inode()
> >        ->ext4_free_inode()
> >    ->iput(new_ea_inode)
> >
> > The logic with this patch is:
> > ext4_xattr_set_entry()
> >    ->ext4_xattr_inode_iget(&old_ea_inode)
> >    ->ext4_xattr_inode_write(old_ea_inode, new_value)
> >    ->iput(old_ea_inode)
> >
> > This patch reduces the time it takes to replace xattrs in the ext4.
> > Without this patch, replacing the value of an xattr two million times t=
akes
> > about 45 seconds on Intel(R) Xeon(R) CPU E5-2620 v3 platform.
> > With this patch, the same operation takes only 6 seconds.
> >
> >  [root@client01 sjc]# ./mount.sh
> >  /dev/sdb1 contains a ext4 file system
> >      last mounted on /mnt/ext4 on Mon May  8 17:05:38 2023
> >  [root@client01 sjc]# touch /mnt/ext4/file1
> >  [root@client01 sjc]# gcc test.c
> >  [root@client01 sjc]# time ./a.out
> >
> >  real    0m45.248s
> >  user    0m0.513s
> >  sys 0m39.231s
> >
> >  [root@client01 sjc]# ./mount.sh
> >  /dev/sdb1 contains a ext4 file system
> >      last mounted on /mnt/ext4 on Mon May  8 17:08:20 2023
> >  [root@client01 sjc]# touch /mnt/ext4/file1
> >  [root@client01 sjc]# time ./a.out
> >
> >  real    0m5.977s
> >  user    0m0.316s
> >  sys 0m5.659s
> >
> > The test.c and mount.sh are in [1].
> > This patch passed the tests with xfstests using 'check -g quick'.
> >
> > [1] https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb
> >
> > Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> > ---
> >
> > Changes in v2:
> >  - Fix a problem when ref of an ea_inode not equal to 1
> >  - Link to v1: https://lore.kernel.org/linux-ext4/20230509011042.11781-=
1-sunjunchao2870@gmail.com/
> >
> > fs/ext4/xattr.c | 36 ++++++++++++++++++++++++++++++++++++
> > 1 file changed, 36 insertions(+)
> >
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index d57408cbe903..8f03958bfcc6 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1713,6 +1713,42 @@ static int ext4_xattr_set_entry(struct ext4_xatt=
r_info *i,
> >               }
> >       }
> >
> > +     if (!s->not_found && i->value && here->e_value_inum && i->in_inod=
e) {
> > +             /* Replace xattr value in ea_inode in place */
> > +             int size_diff =3D i->value_len - le32_to_cpu(here->e_valu=
e_size);
> > +
> > +             ret =3D ext4_xattr_inode_iget(inode,
> > +                                             le32_to_cpu(here->e_value=
_inum),
> > +                                             le32_to_cpu(here->e_hash)=
,
> > +                                             &old_ea_inode);
> > +             if (ret) {
> > +                     old_ea_inode =3D NULL;
> > +                     goto out;
> > +             }
> > +             if (ext4_xattr_inode_get_ref(old_ea_inode) =3D=3D 1) {
> > +                     if (size_diff > 0)
> > +                             ret =3D ext4_xattr_inode_alloc_quota(inod=
e, size_diff);
> > +                     else if (size_diff < 0)
> > +                             ext4_xattr_inode_free_quota(inode, NULL, =
-size_diff);
> > +                     if (ret)
> > +                             goto out;
> > +
> > +                     ret =3D ext4_xattr_inode_write(handle, old_ea_ino=
de, i->value, i->value_len);
> > +                     if (ret) {
> > +                             if (size_diff > 0)
> > +                                     ext4_xattr_inode_free_quota(inode=
, NULL, size_diff);
> > +                             else if (size_diff < 0)
> > +                                     ret =3D ext4_xattr_inode_alloc_qu=
ota(inode, -size_diff);
> > +                             goto out;
> > +                     }
> > +                     here->e_value_size =3D cpu_to_le32(i->value_len);
> > +                     new_ea_inode =3D old_ea_inode;
> > +                     old_ea_inode =3D NULL;
> > +                     goto update_hash;
> > +             } else
> > +                     iput(old_ea_inode);
> > +     }
> > +
> >       /*
> >        * Getting access to old and new ea inodes is subject to failures=
.
> >        * Finish that work before doing any modifications to the xattr d=
ata.
> > --
> > 1.8.3.1
> >
>
>
> Cheers, Andreas
>
>
>
>
>

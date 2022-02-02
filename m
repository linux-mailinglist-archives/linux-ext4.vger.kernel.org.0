Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC14A71B7
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 14:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiBBNkk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 08:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiBBNkk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 08:40:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1B3C061714
        for <linux-ext4@vger.kernel.org>; Wed,  2 Feb 2022 05:40:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k13so8450455lfg.9
        for <linux-ext4@vger.kernel.org>; Wed, 02 Feb 2022 05:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVhgX2tDWcLSxVng5TDedUkwD+MveQu2foKjVrlMvMg=;
        b=Jbf+q4HXmkr/MypZoEc7rpn8O5Drl7MAgHsNoaqLee8oIcxmx1Q9VMDPGCRcehvjQ4
         1k8k/FuS2JFoTqMLwKQV2wfW+FDNn0SJ9emaXEqcCYQVx+5ifq4mE+xZUnu1YzHn67Sg
         jZtU+nQH3JuaG9UyPFkyT9ZCoRpPgFXAarIJLR97C0KzpPJ09SihCahV8hhADigioMKo
         8Qfuk3FdRgZ0RYuM/Uc7xhORFY68RYtHE9obOPJ5A2GD6bZA5vFKU3oUFUbvSfDgkINF
         45lk0HSSfUBbSi0ERVCrQbVThEGIQHvuYJ8SL31ipyLAB1gqA6atFe6PBDAOsxKZn+sh
         HNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVhgX2tDWcLSxVng5TDedUkwD+MveQu2foKjVrlMvMg=;
        b=ilqmKyrDCQt1X+l7ImesyV3la+jM1e2PLv4Ob25rK8IWlpZZ8jQnpdEJ57q23etu/0
         WO1kM8v32ksUT4sKY1/VKxSVw1XVDT1CRknDm48Fzv1mWX170sKT10sYq+LTYZRLnzqo
         PsijQQU6YL7FSDxVnGssuxc9b7FErpiZiOtU9YkYwSCAsvmJK63RhMjj0LhsatqwqnMb
         XtDZeBiVPaRD1kb7ie9CfzuxVmPYBo1jQPwnG9n6bTysBF5/wOTtYo/33uGvBrRLeKT2
         Smsr32PWtYBP8UWo5tZohXqcO/FQHeV7H2WYZKKc0xEafdmQ2WiD6ZkEFxVDsWC4Wnq/
         Ioxg==
X-Gm-Message-State: AOAM530ABzYb0fT+YbsneO2nEXFWT/DTrsdLtxrMkh5SFlaOeUL4DhEu
        pS2SPOai3tcLnYoFOAqZ4Q1r8mMgVkKNNB6YTsshYQ==
X-Google-Smtp-Source: ABdhPJzL/08+2RWjja6F+gVGQLGnWpYqBl50jYzmWVo1aIVhrFESgMLVRzkmn2X+JY2/sZR1kw5ZaJRuAprI7KYq1Ec=
X-Received: by 2002:a19:4301:: with SMTP id q1mr22130122lfa.170.1643809238353;
 Wed, 02 Feb 2022 05:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20211223032337.5198-1-yinxin.x@bytedance.com> <20211223032337.5198-2-yinxin.x@bytedance.com>
 <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
In-Reply-To: <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Wed, 2 Feb 2022 21:40:28 +0800
Message-ID: <CAK896s4=o9cFFnh0KzhbXSSjWiDFoTqNx0ATzGNH8rxj19+1aw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for
 fast commit replay delete range
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bb850a05d70929e5"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--000000000000bb850a05d70929e5
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 2, 2022 at 4:34 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Hello Xin,
>
> Sorry about revisiting this thread so late :(
> Recently when I was working on one of the fast_commit issue, I got interested
> in looking into some of those recent fast_commit fixes.
>
> Hence some of these queries.
>
> On 21/12/23 11:23AM, Xin Yin wrote:
> > For now ,we use ext4_punch_hole() during fast commit replay delete range
> > procedure. But it will be affected by inode->i_size, which may not
> > correct during fast commit replay procedure. The following test will
> > failed.
> >
> > -create & write foo (len 1000K)
> > -falloc FALLOC_FL_ZERO_RANGE foo (range 400K - 600K)
> > -create & fsync bar
> ^^^^ do you mean "fsync foo" or is this actually a new file create and fsync
> bar?
bar is a new created file, it is the brother file of foo , it would be
like this.
./foo ./bar

>
>
> > -falloc FALLOC_FL_PUNCH_HOLE foo (range 300K-500K)
> > -fsync foo
> > -crash before a full commit
> >
> > After the fast_commit reply procedure, the range 400K-500K will not be
> > removed. Because in this case, when calling ext4_punch_hole() the
> > inode->i_size is 0, and it just retruns with doing nothing.
>
> I tried looking into this, but I am not able to put my head around that when
> will the inode->i_size will be 0?
>
> So, what I think should happen is when you are doing falocate/fsync foo in your
> above list of operations then, anyways the inode i_disksize will be updated
> using ext4_mark_inode_dirty() and during replay phase inode->i_size will hold
> the right value no?
yes, the inode->i_size hold the right value and ext4_fc_replay_inode()
will update inode to the final state, but during replay phase
ext4_fc_replay_inode() usually is the last step,  so before this the
inode->i_size may not correct.

>
> Could you please help understand when, where and how will inode->i_size will be
> 0?
I didn't check why inode->i_size is 0, in this case. I just think
inode->i_size should not affect the behavior of the replay phase.
Another case is inode->i_size may not include unwritten blocks , and
if a file has unwritten blocks at bottom, we can not use
ext4_punch_hole() to remove the unwritten blocks beyond i_size during
the replay phase.

>
> Also - it would be helpful if you have some easy reproducer of this issue you
> mentioned.
The attached test code can reproduce this issue, hope it helps.


>
> -ritesh
>
> >
> > Change to use ext4_ext_remove_space() instead of ext4_punch_hole()
> > to remove blocks of inode directly.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/ext4/fast_commit.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index aa05b23f9c14..3deb97b22ca4 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1708,11 +1708,14 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
> >               }
> >       }
> >
> > -     ret = ext4_punch_hole(inode,
> > -             le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
> > -             le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
> > -     if (ret)
> > -             jbd_debug(1, "ext4_punch_hole returned %d", ret);
> > +     down_write(&EXT4_I(inode)->i_data_sem);
> > +     ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> > +                             lrange.fc_lblk + lrange.fc_len - 1);
> > +     up_write(&EXT4_I(inode)->i_data_sem);
> > +     if (ret) {
> > +             iput(inode);
> > +             return 0;
> > +     }
> >       ext4_ext_replay_shrink_inode(inode,
> >               i_size_read(inode) >> sb->s_blocksize_bits);
> >       ext4_mark_inode_dirty(NULL, inode);
> > --
> > 2.20.1
> >

--000000000000bb850a05d70929e5
Content-Type: text/x-c-code; charset="US-ASCII"; name="del_range_issue.c"
Content-Disposition: attachment; filename="del_range_issue.c"
Content-Transfer-Encoding: base64
Content-ID: <f_kz5kn7lk0>
X-Attachment-Id: f_kz5kn7lk0

I2RlZmluZSBfR05VX1NPVVJDRSANCg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3Rk
bGliLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4NCiNpbmNsdWRl
IDxzdGRsaWIuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCiNpbmNsdWRlIDxmY250bC5oPg0KI2lu
Y2x1ZGUgPHN5cy9zdGF0Lmg+DQoNCiNkZWZpbmUgRklMRV9TSVpFICAxMDI0MDAwDQojZGVmaW5l
IEhPTEVfU1RBUlQJNDA5NjAwDQojZGVmaW5lIEhPTEVfTEVOCTIwNDgwMA0KI2RlZmluZSBIT0xF
X1NISUZFVAkxMDI0MDANCg0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQ0Kew0K
CWludCBmZDsNCglpbnQgcmV0Ow0KCXZvaWQqIGRhdGFfZm9vOw0KCWludCBmZF9iYXI7DQoJY2hh
ciBiYXJfcGF0aFsyNTZdOw0KCQ0KCWlmIChhcmdjICE9IDIpIHsNCgkJcHJpbnRmKCJ1c2FnZTog
YS5vdXQgW2ZpbGUgUGF0aF1cbiIpOw0KCQlleGl0KDEpOw0KCX0NCglzcHJpbnRmKGJhcl9wYXRo
LCIlc19iYXIiLGFyZ3ZbMV0pOw0KCQ0KCXByaW50ZigiZmlsZSBwYXRoOiAlcyBcbiIsYXJndlsx
XSk7DQoJcHJpbnRmKCJmaWxlX2JhciBwYXRoOiAlcyBcbiIsYmFyX3BhdGgpOw0KDQoJZmQgPSAg
b3Blbihhcmd2WzFdLCBPX0NSRUFUIHwgT19SRFdSICAsIDA3NTUpOw0KCWlmIChmZCA8IDApIHsN
CgkJcHJpbnRmKCJvcGVuIGVyciEgXG4iKTsNCgkJZXhpdCgxKTsNCgl9DQoJDQoJZGF0YV9mb28g
PSBtYWxsb2MoRklMRV9TSVpFKTsNCglpZiAoIWRhdGFfZm9vKSB7DQoJCXByaW50ZigibWFsbG9j
IGVyciEgXG4iKTsNCgkJZXhpdCgxKTsNCgl9DQoJDQoJaW50IG9mZnNldF9mb28gPSAwOw0KCWlu
dCB0b193cml0ZV9mb28gPSBGSUxFX1NJWkUgOw0KCWNvbnN0IGNoYXIgKnRleHRfZm9vICA9ICJk
ZGRkZGRkZGRka2xtbm9wcXJzdHV2d3h5ejEyMzQ1NiI7DQoJd2hpbGUgKG9mZnNldF9mb28gPCBG
SUxFX1NJWkUpew0KCQlpZiAodG9fd3JpdGVfZm9vIDwgMzIpew0KCQkJbWVtY3B5KChjaGFyICop
ZGF0YV9mb28rIG9mZnNldF9mb28sIHRleHRfZm9vLCB0b193cml0ZV9mb28pOw0KCQkJb2Zmc2V0
X2ZvbyArPSB0b193cml0ZV9mb287DQoJCX0NCgkJZWxzZSB7DQoJCQltZW1jcHkoKGNoYXIgKilk
YXRhX2Zvbysgb2Zmc2V0X2Zvbyx0ZXh0X2ZvbywgMzIpOw0KCQkJb2Zmc2V0X2ZvbyArPSAzMjsg
DQoJCX0gDQoJfSAJDQoNCglyZXQgPSBwd3JpdGUoZmQsIGRhdGFfZm9vLCBGSUxFX1NJWkUsIDAp
Ow0KCWlmIChyZXQgIT0gRklMRV9TSVpFKSB7DQoJCXByaW50Zigid3JpdGUgZXJyISBbJWRdIFxu
IixyZXQpOw0KCQlleGl0KDEpOw0KCX0JDQoJDQoJcmV0ID0gZmFsbG9jYXRlKCBmZCAsIEZBTExP
Q19GTF9aRVJPX1JBTkdFIHwgRkFMTE9DX0ZMX0tFRVBfU0laRSAsIEhPTEVfU1RBUlQgLCBIT0xF
X0xFTik7DQoJaWYgKCByZXQgPCAwKXsgDQoJCXByaW50ZigiZmFsbG9jYXRlIGVyciEgWyVkXSBc
biIscmV0KTsNCgkJZXhpdCgxKTsNCgl9DQoNCglmZF9iYXIgPSBvcGVuKGJhcl9wYXRoLCBPX0NS
RUFUIHwgT19SRFdSICwgMDc1NSk7DQoJaWYgKGZkX2JhciA8IDApIHsNCgkJcHJpbnRmKCJvcGVu
IGZkX2JhciBlcnIhIFxuIik7DQoJCWV4aXQoMSk7CQkJDQoJfQ0KCWZzeW5jKGZkX2Jhcik7DQoJ
Y2xvc2UoZmRfYmFyKTsNCg0KCXJldCA9IGZhbGxvY2F0ZSggZmQgLCBGQUxMT0NfRkxfUFVOQ0hf
SE9MRXxGQUxMT0NfRkxfS0VFUF9TSVpFICwgSE9MRV9TVEFSVC1IT0xFX1NISUZFVCAsIEhPTEVf
TEVOKTsNCglpZiAoIHJldCA8IDApeyANCgkJcHJpbnRmKCJmYWxsb2NhdGUgZXJyISBbJWRdIFxu
IixyZXQpOw0KCQlleGl0KDEpOw0KCX0NCglmc3luYyhmZCk7DQoJY2xvc2UoZmQpOw0KCWV4aXQo
MCk7DQp9DQo=
--000000000000bb850a05d70929e5--

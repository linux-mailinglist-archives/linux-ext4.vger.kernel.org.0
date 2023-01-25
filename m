Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D967B873
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jan 2023 18:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjAYRX1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Jan 2023 12:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjAYRXN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Jan 2023 12:23:13 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407936EB0
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 09:22:46 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id h12-20020a4a940c000000b004fa81915b1cso3263204ooi.4
        for <linux-ext4@vger.kernel.org>; Wed, 25 Jan 2023 09:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqJXv+IInDU1mKTOWecSjx46uIp9RhIiEah7PjvPLrg=;
        b=QlZyecSvRJAlH7daZiVbTmdMCDJawwIkjqybbPcYd50INvCOOFwycJjGFsDCENBvPF
         JeBM9yeOQDknmaZC6LT0p7wlzLAJo3QYgAn7K1xQNCTJjPrh6oinOxgRNGwGedAqUfeH
         4EF6oknHwKU0N6BIZOc0CJi1hrgM4W0zxm3gicvvOuEGF7JC9HCNICDdMPEAz6Lz/B5y
         FN2dpyuojKkpe3r7ipsFxRIyHaJ4nJmkiiUGkQy6aOsuBhBZ3WzwUsGkq0uXDlGTKFEH
         iRh4N/trPN148wcbBUC1DmqB3ErHQLF9n9pkmMXooLK6oXyXf0aS41iIJv2buhnN7zSu
         X8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqJXv+IInDU1mKTOWecSjx46uIp9RhIiEah7PjvPLrg=;
        b=gDancuiQLPHMlxXi7BLjqf9L4xehTLpfDLjANt6cTi33syn8gDrlBWAJrE4i8sJkE3
         c5UpAJlveFHU10CP9+lWvA89w7iILc0WJXf3UdlEk+3EJAsfWGL7suhsIzKeU2pe2pw8
         ev6dySUkW54vBj9AHdnY0+lb1oQqP97Fi65oWEsF+bE0+dJ+MwcBzL2I9xUfBa5br+kG
         QfBPBW8vtIU8frGfjCkbzDWpBkqr7+Zk0mUo0lMjDEZJJEyPzMfWpYB3ctgPQYEjsJyv
         0qqo1R9mKk9UW9ZQ5xWBdAAgyxM1sS9SIzMVbNqFn0N6VhPZV2+GxiXBPsPyL5gnRPyg
         1Org==
X-Gm-Message-State: AFqh2kq7RQTYdMamBBemggBvtS3JhujbGwZciSWAhpDTpYOn8/Z36NwM
        jAWdCXWJDgjizmCJ3Q7tVW1nNvK2lnkhWoviCyrodjCE+NC0mbGGCIo=
X-Google-Smtp-Source: AMrXdXv634nY3BrnZ3PlTUGlyUi8i7L3YenO2gMgxW5qJ4tF6Xha6yZp+2FFeWeU8OQrXrCFeHpomo5nr++haHZW7UI=
X-Received: by 2002:a25:a408:0:b0:800:28d4:6936 with SMTP id
 f8-20020a25a408000000b0080028d46936mr2303639ybi.431.1674667354997; Wed, 25
 Jan 2023 09:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com> <20230125083851.27759-5-surenb@google.com>
 <Y9D4rWEsajV/WfNx@dhcp22.suse.cz> <CAJuCfpGd2eG0RSMte9OVgsRVWPo+Sj7+t8EOo8o_iKzZoh1MXA@mail.gmail.com>
 <Y9Fh9joU3vTCwYbX@dhcp22.suse.cz>
In-Reply-To: <Y9Fh9joU3vTCwYbX@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 25 Jan 2023 09:22:23 -0800
Message-ID: <CAJuCfpEJ1U2UHBNhLx4gggN3PLZKP5RejiZL_U5ZLxU_wdviVg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: replace vma->vm_flags indirect modification in ksm_madvise
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        chenhuacai@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        qianweili@huawei.com, wangzhou1@hisilicon.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, l.stach@pengutronix.de,
        krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com,
        matthias.bgg@gmail.com, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        tomba@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
        ray.huang@amd.com, kraxel@redhat.com, sre@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        dimitri.sivanich@hpe.com, zhangfei.gao@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com,
        jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de,
        jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net,
        xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, miklos@szeredi.hu,
        mike.kravetz@oracle.com, muchun.song@linux.dev, bhe@redhat.com,
        andrii@kernel.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, tiwai@suse.com,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
        linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
        loongarch@lists.linux.dev, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev,
        dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
        target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org, kexec@lists.infradead.org,
        linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        selinux@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 25, 2023 at 9:08 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 25-01-23 08:57:48, Suren Baghdasaryan wrote:
> > On Wed, Jan 25, 2023 at 1:38 AM 'Michal Hocko' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > On Wed 25-01-23 00:38:49, Suren Baghdasaryan wrote:
> > > > Replace indirect modifications to vma->vm_flags with calls to modifier
> > > > functions to be able to track flag changes and to keep vma locking
> > > > correctness. Add a BUG_ON check in ksm_madvise() to catch indirect
> > > > vm_flags modification attempts.
> > >
> > > Those BUG_ONs scream to much IMHO. KSM is an MM internal code so I
> > > gueess we should be willing to trust it.
> >
> > Yes, but I really want to prevent an indirect misuse since it was not
> > easy to find these. If you feel strongly about it I will remove them
> > or if you have a better suggestion I'm all for it.
>
> You can avoid that by making flags inaccesible directly, right?

Ah, you mean Peter's suggestion of using __private? I guess that would
cover it. I'll drop these BUG_ONs in the next version. Thanks!

>
> --
> Michal Hocko
> SUSE Labs

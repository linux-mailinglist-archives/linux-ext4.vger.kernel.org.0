Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241E63A879
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Nov 2022 13:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiK1Mda (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Nov 2022 07:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiK1Md3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Nov 2022 07:33:29 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3761A05F
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 04:33:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so25402683ejc.4
        for <linux-ext4@vger.kernel.org>; Mon, 28 Nov 2022 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKYyx4Z602pjx3oRplZZkXNppkmjyJjNSindp0f6zzg=;
        b=T7dF4IVx6mAe8PDzXOxBsPLT01KG09vhzp684b+VzXYYJdJvnWT3SdjQDDOiVgRsdo
         wZYMH65PUsF3m7CcIKYQGjCoMt7xr/cBqKdtrFsSJsvCQGwHBFbRjaX+64qaSkPTKbwS
         HOCEnSgtQ1HRXWYQjdx0kh9XvoYTGF5T8QMqGuQXcuL+1ZPT6i36DladauAE3f3jSKgg
         hM0wHNyN67Va1FZrtN+P/kdCjSExfoFaYJl1E9c20WtXp8ezVNjkJUnpPGESWfzUa1uU
         8a7T3b76w+teJIs3eCvSSDtQpbF6lI7ooaDS4zl7aXV6ORkdhIPtycigVt3N8Z78bdvI
         VErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKYyx4Z602pjx3oRplZZkXNppkmjyJjNSindp0f6zzg=;
        b=D+OhEewCA4w1V7qpKojRtxgE+SPw/FpjAHSgNPwAsZJNIJpwvVagEpuYPNcXWLiVUo
         0UhCqRSVUQch6Sh9gMkJckjvlb2dXQTfjqWsjXsabv+z+s4DusOuidsYQOyht/WvEptN
         ivpwVU/Hxg+7bqATSLiwWw05EKM+iz2riO6WOomBgOlNirUztxJSStq5IuVL3j19T0t7
         Jc+Q2rguvlm/zNX086BCsPPo4wIdOZ+gSPfC0XQtnOiSIr3MK9r2ZOAIVVB6b7L9it0V
         11ZdHUgkRbo1vFbOAwFG+lwCl9QhZTcuzeYMCFghOTw/GVkKWzHQ7hqblJDhGpkfO9RN
         4PFQ==
X-Gm-Message-State: ANoB5plRT0XiuGKhI0/ELkipEwd3rYLi1lZC+Vc8HHo/9jFsQT2/d1sY
        Szhomd6QBK/DF0Lg8LbFV5dEaIlArnReoEBLbkA=
X-Google-Smtp-Source: AA0mqf6jkXa62TU+4VrmUI1vs48G5mqHoKY5gOu08ynChxbtTqc9TV+AmvGGFdCJtoK0d+Qf7imRo74FSSA+FcWl02Y=
X-Received: by 2002:a17:906:d8db:b0:7ba:8633:7f7b with SMTP id
 re27-20020a170906d8db00b007ba86337f7bmr20332477ejb.206.1669638806371; Mon, 28
 Nov 2022 04:33:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:31d1:b0:78a:ea50:8b61 with HTTP; Mon, 28 Nov 2022
 04:33:24 -0800 (PST)
Reply-To: mmelizabethjohnson@gmail.com
In-Reply-To: <CAM+=Tq9d+oSe1rSQ4yETdZjks73=1n0De1_6sTm9iGRttAdpjA@mail.gmail.com>
References: <CAM+=Tq9sN43MRcSkE+ZtpuO8RBBA5q0agtrr9Jf63rHxXxfjCQ@mail.gmail.com>
 <CAM+=Tq9hsiP-6nFcy1vo_xR0cKgWaS=fcJ-NziZ8Q_aYPMz9eg@mail.gmail.com>
 <CAM+=Tq9P0qvD=p5OfkPR_jvVAvRCzh+7rVahRG8Mk08ChsiTDw@mail.gmail.com>
 <CAM+=Tq9a_VLH=boz2TTfwMvR4A7wHo2bWLn6nbZOOwYGTYBUTw@mail.gmail.com>
 <CAM+=Tq-nt=+FzpBi=pOVjzifutZdRb=k3fn2pyGVfQYFyUw9_A@mail.gmail.com>
 <CAM+=Tq9k3fAon+8PxSgpqGBYVjj6kvmt5y0+Nz-Ynmard-R8yg@mail.gmail.com>
 <CAM+=Tq-2Gu9eAotyUu8kUOkZdTx6aiec0BrBU+xVT89oyQPD8g@mail.gmail.com>
 <CAM+=Tq9XRTEatMFE=wuXuKKFhtSfN+gn=4L0-9bkUJUTYcZCLQ@mail.gmail.com>
 <CAM+=Tq9Qa07o46RROSpBct0yVGgeiS9xxz2GLJaCy6Kz7pqk5w@mail.gmail.com>
 <CAM+=Tq-iHGs3T-EYfM6bkh17S5NG6_KUCOHDuhU=trmFxeDyPQ@mail.gmail.com>
 <CAM+=Tq8vqQ2oYkC35_bJe2Kk-oekYMuyW6eL=XqLXPtzQ5xCOA@mail.gmail.com>
 <CAM+=Tq9m_62g4wWydKXf3nPqiiqwUnXW7RnUxUhYeqg7kV=Gtw@mail.gmail.com>
 <CAM+=Tq8Dq1L09F8nc42cBLgkh5+tNpzT9cUusdMNiS=D+coO9A@mail.gmail.com>
 <CAM+=Tq_A6fvxnjQvs5Xk8XkD4TLYs-5KJbkLR8MoURxjYViSGQ@mail.gmail.com>
 <CAM+=Tq-Od8H0=knnirDHR+Y1kwso=h09RhZn1WN80fHwWuzC6w@mail.gmail.com>
 <CAM+=Tq_sb1qAWQggn+EupELk4pppZ1VHDVzLCTVSUipBY3yX3A@mail.gmail.com>
 <CAM+=Tq-dYOYSayoZBUao38qYm6b+PudHh1qsngDBtaTAhPqxww@mail.gmail.com>
 <CAM+=Tq9-fsWL35xW4_4CUZDa0Vdb78RnsRSQGgPTmn7+w_qcAw@mail.gmail.com>
 <CAM+=Tq-YVkroBbLcsxsoPBgNfNdP1=2HTj8PLqcn-4gO-gPUfw@mail.gmail.com>
 <CAM+=Tq-fBHFXqXorz7njFw6rrMxVYsv+6BEJKyeGnRtsV7iBHw@mail.gmail.com>
 <CAM+=Tq9zxainyi-Z-uL0YsMruZWG8_1dTsE6o49rqx3mp7bstQ@mail.gmail.com>
 <CAM+=Tq8qDkUGytCAijp6b8F10OpiBWi0h7+7MkNk-SD1X15qiA@mail.gmail.com>
 <CAM+=Tq-c7foxKfGfi8acdV-=puZ5q1Ku8b6DR4f0GbREDWpPkg@mail.gmail.com>
 <CAM+=Tq-nx68_yod0qxfx6Td5nFPpi1AF+hd0jgUhAieqKLx21g@mail.gmail.com>
 <CAM+=Tq9=J3bx-TAwksf4HLTS_ci6WUaiSox=9s8qsZQRF5tihQ@mail.gmail.com>
 <CAM+=Tq-xgZ=UcDga-HQb_P6=7sAPR3cVa7j9UX9V7uoKZQy6Qg@mail.gmail.com>
 <CAM+=Tq9w1=qeuiHF6m7TX-=wcaWPx2Bb-tc+nhrkaGKSQrzgHg@mail.gmail.com>
 <CAM+=Tq8XOrmXs2ATxRzcX84u3unVGZ=BvHTMu5uqWZ9-A2q7ZA@mail.gmail.com>
 <CAM+=Tq8jvx651dfpNUFC+7Q41dNg+ebcxSFqHNWZg+=NeF-8jQ@mail.gmail.com>
 <CAM+=Tq8s1_6o1rQQ6Xj8CvzJpZ9uERjSEWdw6DLEQxzckraNXQ@mail.gmail.com>
 <CAM+=Tq9=sem8svMbOU-OZpYeiNgDw6Mtdx321s=VaKz26vXLDw@mail.gmail.com>
 <CAM+=Tq-br8FAikUefSYDdF1VZ5L=cwUH+SQ5WePqPrPqPnDmTw@mail.gmail.com>
 <CAM+=Tq9ujucNLLP23WCzNtKXUUUNKvK=QcVrtJ9B4Vo0186SYw@mail.gmail.com>
 <CAM+=Tq82oTR+OQXArwqAe2_B6Gs9e=GZZBDn2QuLuJt3NwMvEQ@mail.gmail.com>
 <CAM+=Tq8MGYThZ8vCNLLeSPbgQiOTKr8q0+faF7sDp9ZXUbr0AQ@mail.gmail.com>
 <CAM+=Tq9S4q8RaBt3FFf9aXdx8aH1aevNb2nooRn7a9DowYwDYg@mail.gmail.com>
 <CAM+=Tq--Q_=ce6BCEiy6dDa9Lyw+=G3TyVqSkP6nRwYNbcYrVw@mail.gmail.com>
 <CAM+=Tq-S7eSSc7FEiWpJEJn-LcpYTKi-W1W4dmuEEtR9SBqwaw@mail.gmail.com>
 <CAM+=Tq8s1Y9ByRczNM6LZknbHc-4DRgf7yvoeky2Tjvh78DzWQ@mail.gmail.com>
 <CAM+=Tq9eHz4pixRigikewVcF_bkoy8SeE4vbPtwKFTYo0sa1qw@mail.gmail.com>
 <CAM+=Tq9mKr0uDuJKeFuSNh6Ozmm5L+9z6V3fWuDWX+mr=0+phg@mail.gmail.com>
 <CAM+=Tq8b_FD5O1EoRbMrV3y6pn4zE0DTfdi+tFWunqO-FTv8HQ@mail.gmail.com>
 <CAM+=Tq9Jt8RyE4u0yKf28wj+5ddzDAYOxUYFqVh7WZP30JcPjg@mail.gmail.com>
 <CAM+=Tq9hfiqGybHA8WhmUVGygxsxEE8o8eGSfz8DU7qU5tr+8Q@mail.gmail.com>
 <CAM+=Tq-18BRnSuBuMGwsNOXEOxdWxnE5uHzjNy18THu4mcBsRQ@mail.gmail.com>
 <CAM+=Tq-LeYJNRFkV+TVc31TcsuJ7dgTE10fUb4S15urE6aidUA@mail.gmail.com>
 <CAM+=Tq9fYUYmbddDHFKqZ5K5JvWT_F=hZo3wQGiYTAnO9MAe0A@mail.gmail.com>
 <CAM+=Tq-0khi6vN1Q67TGOtda05YkV5YPfqO4LP4sqEFBnesw=Q@mail.gmail.com>
 <CAM+=Tq8LDm0qSasC49NFzyTNbDGL5Wje-RkW9BEgDdvn_np9dw@mail.gmail.com>
 <CAM+=Tq8zG7WQWxrbBoZGdiH0KQRugptPs8VUv=5KQyu-N4wQyw@mail.gmail.com>
 <CAM+=Tq_9bUr1Xab2+UztZYK37n4KbtE_rveQPaEUpdqRmHLYuA@mail.gmail.com>
 <CAM+=Tq9ibkLsBjDdO0b4=ZCYE8QPWk=X812DFRB1S6i+0_Vr6g@mail.gmail.com>
 <CAM+=Tq-XSXetRTrXk6WRZRSTrBNh31dWmhErJuA7moQ=PLpcmQ@mail.gmail.com>
 <CAM+=Tq_GG+2uDNx4WYoG+4F2uP9kZACSGw7VReF83zgqLUB8Mw@mail.gmail.com>
 <CAM+=Tq9oRQuPt+oye09qx8apG4eT4ABBLqJLZwFQUOOUQebarw@mail.gmail.com>
 <CAM+=Tq8zw4FfOzzpoKNnbVU6BnXSvvqDW2iAw-dgm3woaHF8mw@mail.gmail.com>
 <CAM+=Tq9ro08CEcnhC4n7R+eCfvR1wK08gxbofccuOc8yZcQ-eg@mail.gmail.com>
 <CAM+=Tq-cz39zoPth7ONFXPh2B30OwOFWQpyxFysePXgAys=2YQ@mail.gmail.com>
 <CAM+=Tq9Nbb9JHoojsxDhB4KTdpMjq8sy4A0RuwXRL-YGMW9CFg@mail.gmail.com>
 <CAM+=Tq_WFTTOu_MQ07iKHH83MowCGDp8heJ7f+7tGr=peHGM_g@mail.gmail.com>
 <CAM+=Tq_L1P35+xp+sjzXTGvWPULZssKf-wozwVBiFSgmxH8vvw@mail.gmail.com>
 <CAM+=Tq_DVZm22e6WDMp1tFfPxsDhaYLODijmtTqTqWjvEVr38w@mail.gmail.com>
 <CAM+=Tq85hHN5_KkpCCPP=oBS_OFSMLymc=tPEjdy+iDCRe3fNQ@mail.gmail.com>
 <CAM+=Tq-zk7v6VbwcP_bTaeyK7xZUGnBciKkBqB8msPyeH2j98Q@mail.gmail.com>
 <CAM+=Tq_vprCgfjJ0C9Y2RTOGsFcbdn-FBKfgZS=97CajdjEX_Q@mail.gmail.com>
 <CAM+=Tq-TqZQ9HV0vwK+yjaeYx07yiMu+RvA0kmi_vp96JYzQxQ@mail.gmail.com>
 <CAM+=Tq-LkarYBQ45BX+5+Skg6--ozS28KvxLXukVaM9CMF1wBA@mail.gmail.com>
 <CAM+=Tq_59oTAHGHkbLgFMK7gOn+QdbDAiGcASxtLiRViTrky=A@mail.gmail.com>
 <CAM+=Tq8wAnbmu_+3BOuqby7TT3AwU3=EBE4m_91sf2gohwVqQA@mail.gmail.com>
 <CAM+=Tq-Nym4x-rf-0AzNWe3ZBrRtYJ_yjyWH0g+8TA-TpfgnEQ@mail.gmail.com>
 <CAM+=Tq-bA_DJds-dhNHatEGYQ4MmD-foMohuM-H+gaVvMpNR9w@mail.gmail.com>
 <CAM+=Tq_KukWrcSerq46n2VxJhtrPGR3t45JBwnpEAvA4xEDoAQ@mail.gmail.com>
 <CAM+=Tq9f5HJzYZD=abUpJpq6NjXY17ZZV5EfNS6Viet-tSmQ6A@mail.gmail.com>
 <CAM+=Tq8CPhH501U1KtCzXDM8acZbGPtNqw_=uLrPq7dFd47vFw@mail.gmail.com>
 <CAM+=Tq-9nJrUu7V3_q3X42g9AK9in8vFjfvivqR9WsTLjykbig@mail.gmail.com>
 <CAM+=Tq8qaS4E9pFD5EYnyGi35iVgNPn=YtJU8=BYmJyDP04tLQ@mail.gmail.com>
 <CAM+=Tq8Hip3U8W7d+Gew1d7Zvnvyf5NoE6hOL+JpVJQx2G3PJw@mail.gmail.com>
 <CAM+=Tq9t+gT-sEExy8YbXnvgh=cgu0ihfG8WUXAVwrfco17a5g@mail.gmail.com>
 <CAM+=Tq_Oue+68duRZ3mX+5aGeRaYOd0qsMp9KrOk4HQr+5-JSA@mail.gmail.com>
 <CAM+=Tq8wunTEQXizumSZC6oRpWrk+oy+rrkL1vYwNrER0e8HEQ@mail.gmail.com>
 <CAM+=Tq9hwamK8hg+5jPuQo5mp4UMp2F03nt2g8C88BybDS-o5Q@mail.gmail.com>
 <CAM+=Tq8xor6t_r-0gQ0-SfVGcf1ps0=daMc3q+XfC9JN2+YEZg@mail.gmail.com>
 <CAM+=Tq9qAeihOoKxQ8P2MSV4rt4Q61Rpk5k9qvLV7y0v=2mAcw@mail.gmail.com>
 <CAM+=Tq8zGkYT8syf2pTO5A09w4AbA65cBiybenOdnt8JdC=0gQ@mail.gmail.com>
 <CAM+=Tq_FrqymR2BUiC7T7nUqXs0KUJyRFppiBd+QY3-K_53x3Q@mail.gmail.com>
 <CAM+=Tq8ZRo9ZXQfxZpuSX=UwVYZ=XYJi+cdYynDOPrRUOE8aDw@mail.gmail.com>
 <CAM+=Tq9RBQzW5xSwDNmaUAt6Gu4i+Or90YBr_hAU7JvHrUgQpA@mail.gmail.com>
 <CAM+=Tq9vHWeHK32RNTsDOG-Z6+TOBFZjYVMHn8e8bz4w=cO0Yg@mail.gmail.com>
 <CAM+=Tq-gpNXJfDHjq9e2eE0sH5aRNkZ5Rw12tAPuBGC_UmXUfQ@mail.gmail.com>
 <CAM+=Tq-iW3JBWseZX-568R2msNzOkz_6sKB7wfDSC7D91w_y_A@mail.gmail.com>
 <CAM+=Tq-8V4ZGyanRzNWMYCOoJS5OF8swmm7Ps_Qz1Oqj0+ARxg@mail.gmail.com>
 <CAM+=Tq8DM5R0JMC5NB5w+cs=3SWZRn+Q0Bt8F=XhVKDNo5FU4g@mail.gmail.com>
 <CAM+=Tq-406KHMHq1D5AGOsqRsg1PtL0KQQrxwfiSNZ=nK5rhuw@mail.gmail.com>
 <CAM+=Tq85F_jppgkYWiUnpbL=EipN4ZeLiucF8bCbc8J0xMnJ-Q@mail.gmail.com>
 <CAM+=Tq99f3fXDk=_5VCUrkawWRP_AQ=bG9=VP+67wMhAAV=vxw@mail.gmail.com>
 <CAM+=Tq9-pu_oJ_JB2x86WS93o98ge94jLoFsrfg64K7EbPW69g@mail.gmail.com>
 <CAM+=Tq_DvYvVDnSk1NK7oHPGDSB7AkJMy-=R=4hCg8GGB7uqzw@mail.gmail.com> <CAM+=Tq9d+oSe1rSQ4yETdZjks73=1n0De1_6sTm9iGRttAdpjA@mail.gmail.com>
From:   Mrs Sylvia Pieterse <mrssylviapieterse47@gmail.com>
Date:   Mon, 28 Nov 2022 14:33:24 +0200
Message-ID: <CAM+=Tq-kLv=SPNOn3hjHOPgXFx7FsAA39BGQoNX5_pL=O9e0cA@mail.gmail.com>
Subject: RE
To:     undisclosed-recipients:;
Content-Type: multipart/mixed; boundary="000000000000f5131c05ee871397"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_FREEMAIL_DOC_PDF,T_FREEMAIL_DOC_PDF_BCC,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--000000000000f5131c05ee871397
Content-Type: text/plain; charset="UTF-8"

FIND THE ATTACHED FILE

--000000000000f5131c05ee871397
Content-Type: application/pdf; name="DONATION.pdf"
Content-Disposition: attachment; filename="DONATION.pdf"
Content-Transfer-Encoding: base64
X-Attachment-Id: file1

JVBERi0xLjUKJeLjz9MKNyAwIG9iago8PAovVHlwZSAvRm9udERlc2NyaXB0b3IKL0ZvbnROYW1l
IC9UaW1lcyMyME5ldyMyMFJvbWFuCi9GbGFncyAzMgovSXRhbGljQW5nbGUgMAovQXNjZW50IDg5
MQovRGVzY2VudCAtMjE2Ci9DYXBIZWlnaHQgNjkzCi9BdmdXaWR0aCA0MDEKL01heFdpZHRoIDI2
MTQKL0ZvbnRXZWlnaHQgNDAwCi9YSGVpZ2h0IDI1MAovTGVhZGluZyA0MgovU3RlbVYgNDAKL0Zv
bnRCQm94IFstNTY4IC0yMTYgMjA0NiA2OTNdCj4+CmVuZG9iago4IDAgb2JqClsyNTAgMCAwIDAg
NTAwIDAgMCAxODAgMzMzIDMzMyAwIDAgMjUwIDAgMjUwIDI3OCA1MDAgNTAwIDUwMCAwIDAgNTAw
IDUwMCAwIDAgMCAwIDAgMCAwIDAgMCA5MjEgNzIyIDY2NyA2NjcgNzIyIDYxMSA1NTYgNzIyIDAg
MzMzIDM4OSAwIDYxMSA4ODkgMCA3MjIgNTU2IDAgNjY3IDU1NiAwIDcyMiAwIDAgMCAwIDAgMCAw
IDMzMyAwIDAgMCA0NDQgNTAwIDQ0NCA1MDAgNDQ0IDMzMyA1MDAgNTAwIDI3OCAyNzggNTAwIDI3
OCA3NzggNTAwIDUwMCA1MDAgNTAwIDMzMyAzODkgMjc4IDUwMCA1MDAgNzIyIDUwMCA1MDAgNDQ0
XQplbmRvYmoKNiAwIG9iago8PAovVHlwZSAvRm9udAovU3VidHlwZSAvVHJ1ZVR5cGUKL05hbWUg
L0YxCi9CYXNlRm9udCAvVGltZXMjMjBOZXcjMjBSb21hbgovRW5jb2RpbmcgL1dpbkFuc2lFbmNv
ZGluZwovRm9udERlc2NyaXB0b3IgNyAwIFIKL0ZpcnN0Q2hhciAzMgovTGFzdENoYXIgMTIyCi9X
aWR0aHMgOCAwIFIKPj4KZW5kb2JqCjkgMCBvYmoKPDwKL1R5cGUgL0V4dEdTdGF0ZQovQk0gL05v
cm1hbAovY2EgMQo+PgplbmRvYmoKMTAgMCBvYmoKPDwKL1R5cGUgL0V4dEdTdGF0ZQovQk0gL05v
cm1hbAovQ0EgMQo+PgplbmRvYmoKMTEgMCBvYmoKPDwKL0ZpbHRlciAvRmxhdGVEZWNvZGUKL0xl
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
zdyJWEykVoyxzZeMHwTJO5aIw+LNn/+xBpAoNaukKLsJZR0sMeiNmCJDopVorGgmVnIsvnSp4kvd
qd+fPH2favqqEmU0+w9bXSNzRxWBk6D9IN1jRuzYdeUdR3MX4rUdl44+3Ogx147CUjUAE3PwTHcD
JfBB30GtB3jln/GMxRo8hlOcTpnchl2dCA5kP3d5drw3VsI0SE6k/M6DHJ5VLxcUeiYwIi1MloOo
Y4uDGn6AQVgVwYQxhtD5Ye0fOFEPoCmi9VxI77zuLCHGPiYWwjIQ3EIuYtnYeEI1vSb/qPKOBYix
S02M62DuQucla/84Zh8mK6mVXTSiju9jhAGKsZZPjP3G2lf0KczzxrVUTmjpmGvHSOFbBqNERuch
kBzk2uyqUDJiWqv8peqnFLE3Brg3K/Qw4tBRNr94JbG+69wysQ1VQynilZNDbBwwRF5L54JbnoCz
M4VRumS81NYD66ga6PklXuoAqzXFdnZK5xdKPXz2q+sjKzvTVxrloTuNFEaQzt8zFGFzPIYV/MF3
+gmcJObsBePD1zbTKr/rRB9rfx0UzkfuhaJFTxd92Ch+Mhpu8NJcaqBrgVGY8OVmwwBdu7K1bqgU
Gojbj08E81iSjSbjY4xvQP7d01Euwjn9eOwBR2EXdG/seTIYTSIc6ltRV1P6PMY3h0R8s2pr8els
t0x1/bpqCiHj3f+UmzPnPeX57LB57Mp0fC2vZhEd8/mRYumCznCxcluNVW6jw0JdvwFqSvc3wcBv
dDBkF6PNa2uaf5CLrcKbvF/nqsWSiv+8kpzM7GSlT7wnBG+DiOOLv6WaVCVVXTc16Zi1/Qs7xeIq
CmVuZHN0cmVhbQplbmRvYmoKNSAwIG9iago8PAovVHlwZSAvUGFnZQovTWVkaWFCb3ggWzAgMCA2
MTIgNzkyXQovUmVzb3VyY2VzIDw8Ci9Gb250IDw8Ci9GMSA2IDAgUgo+PgovRXh0R1N0YXRlIDw8
Ci9HUzcgOSAwIFIKL0dTOCAxMCAwIFIKPj4KL1Byb2NTZXQgWy9QREYgL1RleHQgL0ltYWdlQiAv
SW1hZ2VDIC9JbWFnZUldCj4+Ci9Db250ZW50cyAxMSAwIFIKL0dyb3VwIDw8Ci9UeXBlIC9Hcm91
cAovUyAvVHJhbnNwYXJlbmN5Ci9DUyAvRGV2aWNlUkdCCj4+Ci9UYWJzIC9TCi9TdHJ1Y3RQYXJl
bnRzIDAKL1BhcmVudCAyIDAgUgo+PgplbmRvYmoKMTIgMCBvYmoKPDwKL1MgL1AKL1R5cGUgL1N0
cnVjdEVsZW0KL0sgWzBdCi9QIDEzIDAgUgovUGcgNSAwIFIKPj4KZW5kb2JqCjE0IDAgb2JqCjw8
Ci9TIC9QCi9UeXBlIC9TdHJ1Y3RFbGVtCi9LIFsxXQovUCAxMyAwIFIKL1BnIDUgMCBSCj4+CmVu
ZG9iagoxNSAwIG9iago8PAovUyAvUAovVHlwZSAvU3RydWN0RWxlbQovSyBbMl0KL1AgMTMgMCBS
Ci9QZyA1IDAgUgo+PgplbmRvYmoKMTYgMCBvYmoKPDwKL1MgL1AKL1R5cGUgL1N0cnVjdEVsZW0K
L0sgWzNdCi9QIDEzIDAgUgovUGcgNSAwIFIKPj4KZW5kb2JqCjE3IDAgb2JqCjw8Ci9TIC9QCi9U
eXBlIC9TdHJ1Y3RFbGVtCi9LIFs0XQovUCAxMyAwIFIKL1BnIDUgMCBSCj4+CmVuZG9iagoxOCAw
IG9iago8PAovUyAvUAovVHlwZSAvU3RydWN0RWxlbQovSyBbNV0KL1AgMTMgMCBSCi9QZyA1IDAg
Ugo+PgplbmRvYmoKMTkgMCBvYmoKPDwKL1MgL1AKL1R5cGUgL1N0cnVjdEVsZW0KL0sgWzZdCi9Q
IDEzIDAgUgovUGcgNSAwIFIKPj4KZW5kb2JqCjIwIDAgb2JqCjw8Ci9TIC9QCi9UeXBlIC9TdHJ1
Y3RFbGVtCi9LIFs3XQovUCAxMyAwIFIKL1BnIDUgMCBSCj4+CmVuZG9iagoyMSAwIG9iago8PAov
UyAvUAovVHlwZSAvU3RydWN0RWxlbQovSyBbOF0KL1AgMTMgMCBSCi9QZyA1IDAgUgo+PgplbmRv
YmoKMjIgMCBvYmoKPDwKL1MgL1AKL1R5cGUgL1N0cnVjdEVsZW0KL0sgWzldCi9QIDEzIDAgUgov
UGcgNSAwIFIKPj4KZW5kb2JqCjIzIDAgb2JqCjw8Ci9TIC9QCi9UeXBlIC9TdHJ1Y3RFbGVtCi9L
IFsxMF0KL1AgMTMgMCBSCi9QZyA1IDAgUgo+PgplbmRvYmoKMTMgMCBvYmoKPDwKL1MgL1BhcnQK
L1R5cGUgL1N0cnVjdEVsZW0KL0sgWzEyIDAgUiAxNCAwIFIgMTUgMCBSIDE2IDAgUiAxNyAwIFIg
MTggMCBSIDE5IDAgUiAyMCAwIFIgMjEgMCBSIDIyIDAgUiAyMyAwIFJdCi9QIDMgMCBSCj4+CmVu
ZG9iagoyNCAwIG9iago8PAovTnVtcyBbMCBbMTIgMCBSIDE0IDAgUiAxNSAwIFIgMTYgMCBSIDE3
IDAgUiAxOCAwIFIgMTkgMCBSIDIwIDAgUiAyMSAwIFIgMjIgMCBSIDIzIDAgUl1dCj4+CmVuZG9i
ago0IDAgb2JqCjw8Ci9Gb290bm90ZSAvTm90ZQovRW5kbm90ZSAvTm90ZQovVGV4dGJveCAvU2Vj
dAovSGVhZGVyIC9TZWN0Ci9Gb290ZXIgL1NlY3QKL0lubGluZVNoYXBlIC9TZWN0Ci9Bbm5vdGF0
aW9uIC9TZWN0Ci9BcnRpZmFjdCAvU2VjdAovV29ya2Jvb2sgL0RvY3VtZW50Ci9Xb3Jrc2hlZXQg
L1BhcnQKL01hY3Jvc2hlZXQgL1BhcnQKL0NoYXJ0c2hlZXQgL1BhcnQKL0RpYWxvZ3NoZWV0IC9Q
YXJ0Ci9TbGlkZSAvUGFydAovQ2hhcnQgL1NlY3QKL0RpYWdyYW0gL0ZpZ3VyZQo+PgplbmRvYmoK
MyAwIG9iago8PAovVHlwZSAvU3RydWN0VHJlZVJvb3QKL1JvbGVNYXAgNCAwIFIKL0sgWzEzIDAg
Ul0KL1BhcmVudFRyZWUgMjQgMCBSCi9QYXJlbnRUcmVlTmV4dEtleSAxCj4+CmVuZG9iagoyIDAg
b2JqCjw8Ci9UeXBlIC9QYWdlcwovS2lkcyBbNSAwIFJdCi9Db3VudCAxCj4+CmVuZG9iagoxIDAg
b2JqCjw8Ci9UeXBlIC9DYXRhbG9nCi9QYWdlcyAyIDAgUgovTGFuZyAoZW4tVVMpCi9TdHJ1Y3RU
cmVlUm9vdCAzIDAgUgovTWFya0luZm8gPDwKL01hcmtlZCB0cnVlCj4+Cj4+CmVuZG9iagoyNSAw
IG9iago8PAovVGl0bGUgKEdyZWV0aW5ncyBpbiB0aGUgbmFtZSBvZiBvdXIgTG9yZCBKZXN1cyBD
aHJpc3QpCi9BdXRob3IgKHBjMTkpCi9DcmVhdG9yIDxGRUZGMDA0RDAwNjkwMDYzMDA3MjAwNkYw
MDczMDA2RjAwNjYwMDc0MDBBRTAwMjAwMDU3MDA2RjAwNzIwMDY0MDAyMDAwMzIwMDMwMDAzMTAw
MzY+Ci9DcmVhdGlvbkRhdGUgKEQ6MjAyMTA5MjcxMTAwMDQrMDAnMDAnKQovUHJvZHVjZXIgKHd3
dy5pbG92ZXBkZi5jb20pCi9Nb2REYXRlIChEOjIwMjEwOTI3MTEwMDA1WikKPj4KZW5kb2JqCnhy
ZWYKMCAyNgowMDAwMDAwMDAwIDY1NTM1IGYNCjAwMDAwMDUxODMgMDAwMDAgbg0KMDAwMDAwNTEy
NiAwMDAwMCBuDQowMDAwMDA1MDE2IDAwMDAwIG4NCjAwMDAwMDQ3MzMgMDAwMDAgbg0KMDAwMDAw
MzM4MSAwMDAwMCBuDQowMDAwMDAwNTc5IDAwMDAwIG4NCjAwMDAwMDAwMTUgMDAwMDAgbg0KMDAw
MDAwMDI2NiAwMDAwMCBuDQowMDAwMDAwNzYzIDAwMDAwIG4NCjAwMDAwMDA4MTkgMDAwMDAgbg0K
MDAwMDAwMDg3NiAwMDAwMCBuDQowMDAwMDAzNjc4IDAwMDAwIG4NCjAwMDAwMDQ0ODIgMDAwMDAg
bg0KMDAwMDAwMzc1MSAwMDAwMCBuDQowMDAwMDAzODI0IDAwMDAwIG4NCjAwMDAwMDM4OTcgMDAw
MDAgbg0KMDAwMDAwMzk3MCAwMDAwMCBuDQowMDAwMDA0MDQzIDAwMDAwIG4NCjAwMDAwMDQxMTYg
MDAwMDAgbg0KMDAwMDAwNDE4OSAwMDAwMCBuDQowMDAwMDA0MjYyIDAwMDAwIG4NCjAwMDAwMDQz
MzUgMDAwMDAgbg0KMDAwMDAwNDQwOCAwMDAwMCBuDQowMDAwMDA0NjIyIDAwMDAwIG4NCjAwMDAw
MDUyOTcgMDAwMDAgbg0KdHJhaWxlcgo8PAovU2l6ZSAyNgovUm9vdCAxIDAgUgovSW5mbyAyNSAw
IFIKL0lEIFs8NDI0ODZFNTMxNTZEMEU2NTA3MEI2NjE5OTcyRjg1MjI+IDxFOTdDMjgxOTVCMzM1
RjA0MjYyRDQ3MkZCMjAzN0E0NT5dCj4+CnN0YXJ0eHJlZgo1NTg0CiUlRU9GCg==
--000000000000f5131c05ee871397--

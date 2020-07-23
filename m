Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C629422A3C0
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jul 2020 02:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbgGWAg5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jul 2020 20:36:57 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:32224
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726685AbgGWAg5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jul 2020 20:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESJ+MgEe+6PpcP3WpGG/+jQeTxCaDFN7JBQimRjg+VUSrkBvz5hqQe8WWS5dd7s1NiNRQAOLGt/qlWPiQcKuSCUsyDuqQMKv/lBRANcX7WV0R82cBS+hDI9KMXOxmprgM3m9IjSZ5rh2DrxxVQqtUElRuvxCPwP1PQywFzyQHZRbblo79iMER0gmpehMnsrp5Vg9UaDAIMIRDBD+v4PjPb8egKf3u83ywV2sFIgwyms0bdYyDEB0Ip/HnHbB/q1Fv3YMRQD1pTRfTYiSVIa2jDv2YsNd6cVS1zh2SPb+d9CTOUgjB8usezOVY/boGv91d1Lc+FHdHWzIVzulva0DoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3GH0rx1mUa0yJST1pw2yQqwyIWDE1aXxlnZfHdMdU=;
 b=d8ZcM/jy3s+DOM3DgzyaG7+qqg5sHhgI9tSJB6CkuC3+o2ekLeCkhcdZW2GdNUSQ1UG60+YeMCYcqchzOnHZofZVoAZZvV8SiYA9ssb5e0NnRifzFOtgs603ZA8if1HNI63M6N7TiFGmjgsqs9uVM32Gyl6ecgXAh2GYS0P/39h9SLHRSGycAIrFPWMg7DxMwIUO0CX8E5/OwWilFXyQ2wMdyhr7R8WSEIUrXuWKPYrUX6t6MYPTRy/kqyyoMDG6DExxpfvNI/b5EH+wN206JU1BApp/zBiNFIUrYKorC/Wgu95UVOTggNAiGlqQjbNY8hBgCHIatuFesuwBjBawtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP3GH0rx1mUa0yJST1pw2yQqwyIWDE1aXxlnZfHdMdU=;
 b=tyTLXmfvg17HnKnmy3Uku4yyQfBUXXiqllB3Uq2rfRP0mJzv5ZKq72FN6G2RJnWfPRKYa9npBoriCMhYlMQya0emtST1K9t0MP/7WWwbRzvWy5xmyjKPbZk6Hx1aD9PX7K4L3nyEi71oUM+VKxcr7R1bC46xh+k3WN9n9OBYfRk=
Received: from CY4PR19MB1205.namprd19.prod.outlook.com (2603:10b6:903:107::21)
 by CY4PR19MB1176.namprd19.prod.outlook.com (2603:10b6:903:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 00:36:52 +0000
Received: from CY4PR19MB1205.namprd19.prod.outlook.com
 ([fe80::e46f:a678:cdb8:f5be]) by CY4PR19MB1205.namprd19.prod.outlook.com
 ([fe80::e46f:a678:cdb8:f5be%12]) with mapi id 15.20.3216.021; Thu, 23 Jul
 2020 00:36:52 +0000
From:   Shuichi Ihara <sihara@ddn.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <azhuravlev@whamcloud.com>
Subject: Re: [PATCH 1/4] ext4: add prefetching for block allocation bitmaps
Thread-Topic: [PATCH 1/4] ext4: add prefetching for block allocation bitmaps
Thread-Index: AQHWXzKP03Sc+RdBCk6JrRjZT/1MV6kUVFGA
Date:   Thu, 23 Jul 2020 00:36:52 +0000
Message-ID: <4416B7DF-84AC-4942-B479-B63CFA7B9DDF@ddn.com>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-2-tytso@mit.edu>
 <1F791FDF-75A7-48D9-A0A7-764D5AEC8E4B@dilger.ca>
In-Reply-To: <1F791FDF-75A7-48D9-A0A7-764D5AEC8E4B@dilger.ca>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
authentication-results: dilger.ca; dkim=none (message not signed)
 header.d=none;dilger.ca; dmarc=none action=none header.from=ddn.com;
x-originating-ip: [240b:11:1b21:ca00:14d9:c726:d246:d40b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc3cdba-042f-46c8-0829-08d82ea07e57
x-ms-traffictypediagnostic: CY4PR19MB1176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR19MB11761D6A33A71A4355A32620DB760@CY4PR19MB1176.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTF6n1iEf9u7Cvl0JnkcEazIf4usRF8JZyE3qLPiblvvVXORs9Ws0HDnDGu3yqOZ0a5+oDicLhcIc0xRsdVwvwHeUvASwe1Y6/MQXDsOX7UmgwBt/TwM1rF8KItKtzLRDFF7F05o1EsWT5rbh0llradLE/eZtJu0h575BayFdfH3ui9oztJPaVm7BlAOhElw52ajsQlnJjKkEX+wgtd8VoJWvhP2+oS0fBErGmRugwM5Q8ph+qUDgluOaPteTJ50MgQ9f+WZ/C6jRy9uKgvVpiYLbBLO1bedCdDuQtIDmFl4h5ViymKVun2j01nx7jYSK6VWq6nVY6UF+JnhbLnQLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR19MB1205.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(66476007)(64756008)(66556008)(107886003)(91956017)(76116006)(66946007)(66446008)(6512007)(316002)(30864003)(54906003)(186003)(2616005)(5660300002)(8676002)(86362001)(36756003)(8936002)(478600001)(6486002)(53546011)(6916009)(6506007)(33656002)(4326008)(71200400001)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WSEzeTOYcKop6KEUltYuTw5BZcKjGXRzDY8okCTPUQCC+/Nz8DdQAarqO5AMPtgpU7vUnYYxmIf8yeZQkkBRi+eJJUdzZa6GpbVj/IAzOg9QuwUv8McS+ZE6nkJDee398qPpRDN9IA36XKB7oBgb9hj1aQhR36OFe8Z1h4LBV0IRZXhLOfAenxglYV1Le46oDaMweY7wq+6ytRtua7ojtpFGpk6rj6F4AHVhAhUHgXRVEpzkgF9hveYcyR+dawjnuaMlT8M7Qfv2+B2QJIoV561GlnewChqNghPN96v+CvuRpK1dGhsT+Ycuuxn/T2dzWlohVnxoPAEk75qXAFVm414I08WoCYRhoP49RNiseEErAMvK5q3j3w6Zc7JB3rvKX4rOpWAWPM0qXGTLqOY+0CrAqpp455NSMp+kvY6YTXce1e01GqWkgmI4vBR6N/3I3JOX95CVoegGxiSvaJbeP1IiLjtgkSYHsM01wt5N5MfxpzBqdjH1Dsp4EEIgK6NmZ4b+AcVbGnk8VW6Vaq13HcYfnRz5tImbW9sJnZr9yHw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C568D24759EF749BC5FF389930DD89F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR19MB1205.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc3cdba-042f-46c8-0829-08d82ea07e57
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 00:36:52.1703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLPVJCBmABgacpULOMF6lb/PJS/VJ+0ewGOb2BNDdW1ZkVVAhWpUUM382LjppwOL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR19MB1176
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Andreas,

> Shuichi, do you have a properly populated large OST that you could test
> this?  Since it is a tunable (/sys/fs/ext4/<dev>/mb_prefetch_limit), it
> should be possible to see the effect on allocation performance at least
> without recompiling the module, though this tunable only appears after
> mount, so you will have a chance to change it right after mount to see
> the effect. Given the long mount time with a bad parameter, this should
> not be hard to observe.

Sure, I will test this on large OST and check if there are any good/bad per=
formance impacts with it.

Thanks
Ihara

> On Jul 21, 2020, at 16:42, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> On Jul 17, 2020, at 9:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>>=20
>> From: Alex Zhuravlev <bzzz@whamcloud.com>
>>=20
>> This should significantly improve bitmap loading, especially for flex
>> groups as it tries to load all bitmaps within a flex.group instead of
>> one by one synchronously.
>>=20
>> Prefetching is done in 8 * flex_bg groups, so it should be 8 read-ahead
>> reads for a single allocating thread. At the end of allocation the
>> thread waits for read-ahead completion and initializes buddy information
>> so that read-aheads are not lost in case of memory pressure.
>>=20
>> At cr=3D0 the number of prefetching IOs is limited per allocation contex=
t
>> to prevent a situation when mballoc loads thousands of bitmaps looking
>> for a perfect group and ignoring groups with good chunks.
>>=20
>> Together with the patch "ext4: limit scanning of uninitialized groups"
>> the mount time (which includes few tiny allocations) of a 1PB filesystem
>> is reduced significantly:
>>=20
>>              0% full    50%-full unpatched    patched
>> mount time       33s                9279s       563s
>>=20
>> [ Restructured by tytso; removed the state flags in the allocation
>> context, so it can be used to lazily prefetch the allocation bitmaps
>> immediately after the file system is mounted.  Skip prefetching
>> block groups which are unitialized.  Finally pass in the REQ_RAHEAD
>> flag to the block layer while prefetching. ]
>>=20
>> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
>> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
>=20
> I re-reviewed the patch with the changes, and it looks OK.  I see that
> you reduced the prefetch limit from 32 to 4 group blocks, presumably to
> keep the latency low?  It would be useful to see what impact that has
> on the mount time and IO performance of a large filesystem.
>=20
> Shuichi, do you have a properly populated large OST that you could test
> this?  Since it is a tunable (/sys/fs/ext4/<dev>/mb_prefetch_limit), it
> should be possible to see the effect on allocation performance at least
> without recompiling the module, though this tunable only appears after
> mount, so you will have a chance to change it right after mount to see
> the effect. Given the long mount time with a bad parameter, this should
> not be hard to observe.
>=20
> Cheers, Andreas
>=20
>> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>> ---
>> fs/ext4/balloc.c  |  14 +++--
>> fs/ext4/ext4.h    |   8 ++-
>> fs/ext4/mballoc.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
>> fs/ext4/sysfs.c   |   4 ++
>> 4 files changed, 152 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
>> index 1ba46d87cdf1..aaa9ec5212c8 100644
>> --- a/fs/ext4/balloc.c
>> +++ b/fs/ext4/balloc.c
>> @@ -413,7 +413,8 @@ static int ext4_validate_block_bitmap(struct super_b=
lock *sb,
>> * Return buffer_head on success or an ERR_PTR in case of failure.
>> */
>> struct buffer_head *
>> -ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t bloc=
k_group)
>> +ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t bloc=
k_group,
>> +			      bool ignore_locked)
>> {
>> 	struct ext4_group_desc *desc;
>> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
>> @@ -441,6 +442,12 @@ ext4_read_block_bitmap_nowait(struct super_block *s=
b, ext4_group_t block_group)
>> 		return ERR_PTR(-ENOMEM);
>> 	}
>>=20
>> +	if (ignore_locked && buffer_locked(bh)) {
>> +		/* buffer under IO already, return if called for prefetching */
>> +		put_bh(bh);
>> +		return NULL;
>> +	}
>> +
>> 	if (bitmap_uptodate(bh))
>> 		goto verify;
>>=20
>> @@ -490,7 +497,8 @@ ext4_read_block_bitmap_nowait(struct super_block *sb=
, ext4_group_t block_group)
>> 	trace_ext4_read_block_bitmap_load(sb, block_group);
>> 	bh->b_end_io =3D ext4_end_bitmap_read;
>> 	get_bh(bh);
>> -	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
>> +	submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO |
>> +		  ignore_locked ? REQ_RAHEAD : 0, bh);
>> 	return bh;
>> verify:
>> 	err =3D ext4_validate_block_bitmap(sb, desc, block_group, bh);
>> @@ -534,7 +542,7 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_=
group_t block_group)
>> 	struct buffer_head *bh;
>> 	int err;
>>=20
>> -	bh =3D ext4_read_block_bitmap_nowait(sb, block_group);
>> +	bh =3D ext4_read_block_bitmap_nowait(sb, block_group, false);
>> 	if (IS_ERR(bh))
>> 		return bh;
>> 	err =3D ext4_wait_block_bitmap(sb, block_group, bh);
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 42f5060f3cdf..7451662e092a 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1505,6 +1505,8 @@ struct ext4_sb_info {
>> 	/* where last allocation was done - for stream allocation */
>> 	unsigned long s_mb_last_group;
>> 	unsigned long s_mb_last_start;
>> +	unsigned int s_mb_prefetch;
>> +	unsigned int s_mb_prefetch_limit;
>>=20
>> 	/* stats for buddy allocator */
>> 	atomic_t s_bal_reqs;	/* number of reqs with len > 1 */
>> @@ -2446,7 +2448,8 @@ extern struct ext4_group_desc * ext4_get_group_des=
c(struct super_block * sb,
>> extern int ext4_should_retry_alloc(struct super_block *sb, int *retries)=
;
>>=20
>> extern struct buffer_head *ext4_read_block_bitmap_nowait(struct super_bl=
ock *sb,
>> -						ext4_group_t block_group);
>> +						ext4_group_t block_group,
>> +						bool ignore_locked);
>> extern int ext4_wait_block_bitmap(struct super_block *sb,
>> 				  ext4_group_t block_group,
>> 				  struct buffer_head *bh);
>> @@ -3145,6 +3148,7 @@ struct ext4_group_info {
>> 	(1 << EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT)
>> #define EXT4_GROUP_INFO_IBITMAP_CORRUPT		\
>> 	(1 << EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT)
>> +#define EXT4_GROUP_INFO_BBITMAP_READ_BIT	4
>>=20
>> #define EXT4_MB_GRP_NEED_INIT(grp)	\
>> 	(test_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &((grp)->bb_state)))
>> @@ -3159,6 +3163,8 @@ struct ext4_group_info {
>> 	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
>> #define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
>> 	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
>> +#define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
>> +	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)=
))
>>=20
>> #define EXT4_MAX_CONTENTION		8
>> #define EXT4_CONTENTION_THRESHOLD	2
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index c0a331e2feb0..8a1e6e03c088 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -922,7 +922,7 @@ static int ext4_mb_init_cache(struct page *page, cha=
r *incore, gfp_t gfp)
>> 			bh[i] =3D NULL;
>> 			continue;
>> 		}
>> -		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group);
>> +		bh[i] =3D ext4_read_block_bitmap_nowait(sb, group, false);
>> 		if (IS_ERR(bh[i])) {
>> 			err =3D PTR_ERR(bh[i]);
>> 			bh[i] =3D NULL;
>> @@ -2209,12 +2209,93 @@ static int ext4_mb_good_group_nolock(struct ext4=
_allocation_context *ac,
>> 	return ret;
>> }
>>=20
>> +/*
>> + * Start prefetching @nr block bitmaps starting at @group.
>> + * Return the next group which needs to be prefetched.
>> + */
>> +static ext4_group_t
>> +ext4_mb_prefetch(struct super_block *sb, ext4_group_t group,
>> +		 unsigned int nr, int *cnt)
>> +{
>> +	ext4_group_t ngroups =3D ext4_get_groups_count(sb);
>> +	struct buffer_head *bh;
>> +	struct blk_plug plug;
>> +
>> +	blk_start_plug(&plug);
>> +	while (nr-- > 0) {
>> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, group,
>> +								  NULL);
>> +		struct ext4_group_info *grp =3D ext4_get_group_info(sb, group);
>> +
>> +		/*
>> +		 * Prefetch block groups with free blocks; but don't
>> +		 * bother if it is marked uninitialized on disk, since
>> +		 * it won't require I/O to read.  Also only try to
>> +		 * prefetch once, so we avoid getblk() call, which can
>> +		 * be expensive.
>> +		 */
>> +		if (!EXT4_MB_GRP_TEST_AND_SET_READ(grp) &&
>> +		    EXT4_MB_GRP_NEED_INIT(grp) &&
>> +		    ext4_free_group_clusters(sb, gdp) > 0 &&
>> +		    !(ext4_has_group_desc_csum(sb) &&
>> +		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
>> +			bh =3D ext4_read_block_bitmap_nowait(sb, group, true);
>> +			if (bh && !IS_ERR(bh)) {
>> +				if (!buffer_uptodate(bh) && cnt)
>> +					(*cnt)++;
>> +				brelse(bh);
>> +			}
>> +		}
>> +		if (++group >=3D ngroups)
>> +			group =3D 0;
>> +	}
>> +	blk_finish_plug(&plug);
>> +	return group;
>> +}
>> +
>> +/*
>> + * Prefetching reads the block bitmap into the buffer cache; but we
>> + * need to make sure that the buddy bitmap in the page cache has been
>> + * initialized.  Note that ext4_mb_init_group() will block if the I/O
>> + * is not yet completed, or indeed if it was not initiated by
>> + * ext4_mb_prefetch did not start the I/O.
>> + *
>> + * TODO: We should actually kick off the buddy bitmap setup in a work
>> + * queue when the buffer I/O is completed, so that we don't block
>> + * waiting for the block allocation bitmap read to finish when
>> + * ext4_mb_prefetch_fini is called from ext4_mb_regular_allocator().
>> + */
>> +static void
>> +ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
>> +		      unsigned int nr)
>> +{
>> +	while (nr-- > 0) {
>> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, group,
>> +								  NULL);
>> +		struct ext4_group_info *grp =3D ext4_get_group_info(sb, group);
>> +
>> +		if (!group)
>> +			group =3D ext4_get_groups_count(sb);
>> +		group--;
>> +		grp =3D ext4_get_group_info(sb, group);
>> +
>> +		if (EXT4_MB_GRP_NEED_INIT(grp) &&
>> +		    ext4_free_group_clusters(sb, gdp) > 0 &&
>> +		    !(ext4_has_group_desc_csum(sb) &&
>> +		      (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT)))) {
>> +			if (ext4_mb_init_group(sb, group, GFP_NOFS))
>> +				break;
>> +		}
>> +	}
>> +}
>> +
>> static noinline_for_stack int
>> ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>> {
>> -	ext4_group_t ngroups, group, i;
>> +	ext4_group_t prefetch_grp =3D 0, ngroups, group, i;
>> 	int cr =3D -1;
>> 	int err =3D 0, first_err =3D 0;
>> +	unsigned int nr =3D 0, prefetch_ios =3D 0;
>> 	struct ext4_sb_info *sbi;
>> 	struct super_block *sb;
>> 	struct ext4_buddy e4b;
>> @@ -2282,6 +2363,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_c=
ontext *ac)
>> 		 * from the goal value specified
>> 		 */
>> 		group =3D ac->ac_g_ex.fe_group;
>> +		prefetch_grp =3D group;
>>=20
>> 		for (i =3D 0; i < ngroups; group++, i++) {
>> 			int ret =3D 0;
>> @@ -2293,6 +2375,29 @@ ext4_mb_regular_allocator(struct ext4_allocation_=
context *ac)
>> 			if (group >=3D ngroups)
>> 				group =3D 0;
>>=20
>> +			/*
>> +			 * Batch reads of the block allocation bitmaps
>> +			 * to get multiple READs in flight; limit
>> +			 * prefetching at cr=3D0/1, otherwise mballoc can
>> +			 * spend a lot of time loading imperfect groups
>> +			 */
>> +			if ((prefetch_grp =3D=3D group) &&
>> +			    (cr > 1 ||
>> +			     prefetch_ios < sbi->s_mb_prefetch_limit)) {
>> +				unsigned int curr_ios =3D prefetch_ios;
>> +
>> +				nr =3D sbi->s_mb_prefetch;
>> +				if (ext4_has_feature_flex_bg(sb)) {
>> +					nr =3D (group / sbi->s_mb_prefetch) *
>> +						sbi->s_mb_prefetch;
>> +					nr =3D nr + sbi->s_mb_prefetch - group;
>> +				}
>> +				prefetch_grp =3D ext4_mb_prefetch(sb, group,
>> +							nr, &prefetch_ios);
>> +				if (prefetch_ios =3D=3D curr_ios)
>> +					nr =3D 0;
>> +			}
>> +
>> 			/* This now checks without needing the buddy page */
>> 			ret =3D ext4_mb_good_group_nolock(ac, group, cr);
>> 			if (ret <=3D 0) {
>> @@ -2367,6 +2472,10 @@ ext4_mb_regular_allocator(struct ext4_allocation_=
context *ac)
>> 	mb_debug(sb, "Best len %d, origin len %d, ac_status %u, ac_flags 0x%x, =
cr %d ret %d\n",
>> 		 ac->ac_b_ex.fe_len, ac->ac_o_ex.fe_len, ac->ac_status,
>> 		 ac->ac_flags, cr, err);
>> +
>> +	if (nr)
>> +		ext4_mb_prefetch_fini(sb, prefetch_grp, nr);
>> +
>> 	return err;
>> }
>>=20
>> @@ -2613,6 +2722,25 @@ static int ext4_mb_init_backend(struct super_bloc=
k *sb)
>> 			goto err_freebuddy;
>> 	}
>>=20
>> +	if (ext4_has_feature_flex_bg(sb)) {
>> +		/* a single flex group is supposed to be read by a single IO */
>> +		sbi->s_mb_prefetch =3D 1 << sbi->s_es->s_log_groups_per_flex;
>> +		sbi->s_mb_prefetch *=3D 8; /* 8 prefetch IOs in flight at most */
>> +	} else {
>> +		sbi->s_mb_prefetch =3D 32;
>> +	}
>> +	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
>> +		sbi->s_mb_prefetch =3D ext4_get_groups_count(sb);
>> +	/* now many real IOs to prefetch within a single allocation at cr=3D0
>> +	 * given cr=3D0 is an CPU-related optimization we shouldn't try to
>> +	 * load too many groups, at some point we should start to use what
>> +	 * we've got in memory.
>> +	 * with an average random access time 5ms, it'd take a second to get
>> +	 * 200 groups (* N with flex_bg), so let's make this limit 4 */
>> +	sbi->s_mb_prefetch_limit =3D sbi->s_mb_prefetch * 4;
>> +	if (sbi->s_mb_prefetch_limit > ext4_get_groups_count(sb))
>> +		sbi->s_mb_prefetch_limit =3D ext4_get_groups_count(sb);
>> +
>> 	return 0;
>>=20
>> err_freebuddy:
>> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>> index 6c9fc9e21c13..31e0db726d21 100644
>> --- a/fs/ext4/sysfs.c
>> +++ b/fs/ext4/sysfs.c
>> @@ -240,6 +240,8 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error=
_func, 32);
>> EXT4_ATTR(first_error_time, 0444, first_error_time);
>> EXT4_ATTR(last_error_time, 0444, last_error_time);
>> EXT4_ATTR(journal_task, 0444, journal_task);
>> +EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
>> +EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
>>=20
>> static unsigned int old_bump_val =3D 128;
>> EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
>> @@ -283,6 +285,8 @@ static struct attribute *ext4_attrs[] =3D {
>> #ifdef CONFIG_EXT4_DEBUG
>> 	ATTR_LIST(simulate_fail),
>> #endif
>> +	ATTR_LIST(mb_prefetch),
>> +	ATTR_LIST(mb_prefetch_limit),
>> 	NULL,
>> };
>> ATTRIBUTE_GROUPS(ext4);
>> --
>> 2.24.1
>>=20
>=20
>=20
> Cheers, Andreas
>=20
>=20
>=20
>=20
>=20

